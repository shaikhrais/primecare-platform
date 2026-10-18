"""Add exclusive verification states without replacing lifecycle status or legacy evidence."""
import json
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
STATES = ('missing', 'implemented-unverified', 'verified', 'blocked')


def register(db):
    columns = {row[1] for row in db.execute('PRAGMA table_info(workflow_definitions)')}
    # Fail rather than silently classify registrations with different specifications.
    if 'verification_status' not in columns:
        unresolved = db.execute("""SELECT COUNT(*) FROM workflow_definitions d
            WHERE NOT EXISTS (SELECT 1 FROM workflow_steps s WHERE s.workflow_id=d.id)
            OR EXISTS (SELECT 1 FROM workflow_steps s WHERE s.workflow_id=d.id
                AND (s.api_id IS NULL OR s.expected_result IS NULL
                OR trim(s.expected_result) IN ('', 'Success')))""").fetchone()[0]
        total = db.execute('SELECT COUNT(*) FROM workflow_definitions').fetchone()[0]
        if unresolved != total:
            raise ValueError('Inventory changed: review specifications before initial classification')
        db.execute("""ALTER TABLE workflow_definitions ADD COLUMN verification_status
            TEXT NOT NULL DEFAULT 'blocked' CHECK(verification_status IN
            ('missing','implemented-unverified','verified','blocked'))""")
        db.execute("ALTER TABLE workflow_definitions ADD COLUMN verification_reason TEXT NOT NULL DEFAULT 'Specification audit required before verification' ")
        db.execute('ALTER TABLE workflow_definitions ADD COLUMN verification_checked_at TEXT')
        db.execute("""UPDATE workflow_definitions SET verification_reason=
            'Incomplete executable specification: missing API bindings and/or measurable expected results; implementation not yet classified',
            verification_checked_at=CURRENT_TIMESTAMP""")
    db.execute('DROP VIEW IF EXISTS workflow_verification_summary')
    db.execute("""CREATE VIEW workflow_verification_summary AS SELECT
        COUNT(*) AS total,
        COALESCE(SUM(verification_status='missing'),0) AS missing,
        COALESCE(SUM(verification_status='implemented-unverified'),0) AS implemented_unverified,
        COALESCE(SUM(verification_status='verified'),0) AS verified,
        COALESCE(SUM(verification_status='blocked'),0) AS blocked
        FROM workflow_definitions""")

    db.execute('CREATE VIEW IF NOT EXISTS role_outline_verification_summary AS SELECT * FROM workflow_verification_summary')

def snapshot(db):
    db.row_factory = sqlite3.Row
    summary = dict(db.execute('SELECT * FROM workflow_verification_summary').fetchone())
    assert summary['total'] == sum(summary[key] for key in
                                    ('missing', 'implemented_unverified', 'verified', 'blocked'))
    rows = [dict(row) for row in db.execute('''SELECT d.id,d.app_id,d.role_id,
        d.workflow_code,d.workflow_name,d.status AS lifecycle_status,
        d.verification_status,d.verification_reason,d.verification_checked_at
        FROM workflow_definitions d ORDER BY d.id''')]
    return {'scope': 'Legacy role/app process outlines in workflow_definitions, not individual business workflows; actual business specifications are in business_workflow_specs',
            'summary': summary, 'workflows': rows}


if __name__ == '__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        register(db)
        report = snapshot(db)
    (ROOT / 'docs/task-progress/registered-workflow-status.json').write_text(
        json.dumps(report, indent=2) + '\n')
    print(json.dumps(report['summary']))
