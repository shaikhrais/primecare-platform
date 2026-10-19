"""Persist resumable workflow attempts, not claims of execution or approval.

Only registered business_process records are counted. Scoped evidence never
promotes a workflow to verified. Full promotion requires the seven current gates,
an externally produced acceptance review and an executed browser/API/database
receipt. As with gates.py, authenticity belongs to the producers/review system;
this recorder validates bindings and completeness, it does not grant approval.
"""
import argparse
import hashlib
import json
import sqlite3
from pathlib import Path
from urllib.parse import urlsplit

from gates import digest, evaluate

ROOT = Path(__file__).resolve().parents[2]
STATUSES = ('missing', 'implemented-unverified', 'verified', 'blocked')
TEST_STATUSES = ('not_run', 'scoped_pass', 'passed', 'failed', 'blocked', 'stale')


def encoded(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True)


def prepare(db):
    """Add execution records without rewriting definitions or business data."""
    if getattr(db, 'is_production_workflow_store', False):
        return  # Constructor verifies pinned schema and keys; never run SQLite DDL.
    schema = '''
    CREATE TABLE IF NOT EXISTS virtual_workflow_attempts(
      attempt_id INTEGER PRIMARY KEY, flow_id TEXT NOT NULL
        REFERENCES virtual_workflow_definitions(flow_id),
      definition_sha256 TEXT NOT NULL, requested_status TEXT NOT NULL
        CHECK(requested_status IN ('missing','implemented-unverified','verified','blocked')),
      test_status TEXT NOT NULL CHECK(test_status IN
        ('not_run','scoped_pass','passed','failed','blocked','stale')),
      scope TEXT NOT NULL CHECK(scope IN ('scoped','workflow')),
      source_bindings_json TEXT NOT NULL, gate_result_json TEXT,
      result_json TEXT NOT NULL, created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    CREATE TABLE IF NOT EXISTS virtual_workflow_issues(
      issue_id INTEGER PRIMARY KEY, attempt_id INTEGER NOT NULL
        REFERENCES virtual_workflow_attempts(attempt_id),
      criterion_id TEXT NOT NULL, reproduction TEXT NOT NULL,
      expected_text TEXT NOT NULL, actual_text TEXT NOT NULL,
      affected_sources_json TEXT NOT NULL);
    CREATE TABLE IF NOT EXISTS virtual_workflow_evidence(
      evidence_id INTEGER PRIMARY KEY, attempt_id INTEGER NOT NULL
        REFERENCES virtual_workflow_attempts(attempt_id),
      kind TEXT NOT NULL, path TEXT NOT NULL, sha256 TEXT NOT NULL,
      url TEXT, UNIQUE(attempt_id,path));
    CREATE TABLE IF NOT EXISTS virtual_workflow_issue_resolutions(
      issue_id INTEGER NOT NULL REFERENCES virtual_workflow_issues(issue_id),
      attempt_id INTEGER NOT NULL REFERENCES virtual_workflow_attempts(attempt_id),
      resolution_note TEXT NOT NULL,
      created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY(issue_id,attempt_id));
    CREATE TABLE IF NOT EXISTS virtual_workflow_checkpoints(
      flow_id TEXT PRIMARY KEY REFERENCES virtual_workflow_definitions(flow_id),
      attempt_id INTEGER NOT NULL REFERENCES virtual_workflow_attempts(attempt_id),
      next_action TEXT NOT NULL, invalidation_json TEXT NOT NULL DEFAULT '[]',
      updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    '''
    # executescript implicitly commits a caller's transaction. Individual DDL
    # statements keep recording composable with a larger governance checkpoint.
    for statement in schema.split(';'):
        if statement.strip():
            db.execute(statement)
    # Earlier checkpoints allowed only one resolution per issue. Preserve that
    # history while permitting a fresh retest after its evidence becomes stale.
    columns = list(db.execute('PRAGMA table_info(virtual_workflow_issue_resolutions)'))
    if next(row[5] for row in columns if row[1] == 'attempt_id') == 0:
        db.execute('ALTER TABLE virtual_workflow_issue_resolutions RENAME TO virtual_workflow_issue_resolutions_old')
        db.execute('''CREATE TABLE virtual_workflow_issue_resolutions(
            issue_id INTEGER NOT NULL REFERENCES virtual_workflow_issues(issue_id),
            attempt_id INTEGER NOT NULL REFERENCES virtual_workflow_attempts(attempt_id),
            resolution_note TEXT NOT NULL,created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY(issue_id,attempt_id))''')
        db.execute('''INSERT INTO virtual_workflow_issue_resolutions
            SELECT issue_id,attempt_id,resolution_note,created_at FROM virtual_workflow_issue_resolutions_old''')
        db.execute('DROP TABLE virtual_workflow_issue_resolutions_old')


def _path(root, name):
    if not isinstance(name, str) or not name or Path(name).is_absolute():
        raise ValueError('Evidence/source paths must be relative to the source root.')
    path = (root / name).resolve()
    if not path.is_relative_to(root):
        raise ValueError('Evidence/source path escapes the source root: ' + name)
    return path


def _bindings_current(bindings, root, *, required=True):
    if not isinstance(bindings, dict) or (required and not bindings):
        return False
    for name, expected in bindings.items():
        try:
            path = _path(root, name)
        except ValueError:
            return False
        if not path.is_file() or digest(path) != expected:
            return False
    return True


def _flow(db, flow_id):
    row = db.execute('''SELECT flow_kind,definition_json,definition_sha256
        FROM virtual_workflow_definitions WHERE flow_id=?''', (flow_id,)).fetchone()
    if not row or row[0] != 'business_process':
        raise ValueError('Expected a registered business_process: ' + flow_id)
    if hashlib.sha256(row[1].encode()).hexdigest() != row[2]:
        raise ValueError('Stored workflow definition hash does not match its bytes.')
    return json.loads(row[1]), row[2]


def acceptance_ids(definition):
    """Stable criterion identities within the bound definition revision."""
    result = ['outcome']
    for key, prefix in (('steps', 'step'), ('preconditions', 'precondition'),
                        ('alternative_paths', 'alternative')):
        result.extend(f'{prefix}:{n}' for n, _ in enumerate(definition.get(key, []), 1))
    return result


def _required_text(value, label):
    if not isinstance(value, str) or not value.strip():
        raise ValueError(label + ' must be nonempty text.')


def _evidence_url(value):
    """URLs are later rendered as links; reject executable or local-file schemes."""
    if value is None:
        return
    if (not isinstance(value, str) or not value
            or any(char.isspace() or ord(char) < 32 for char in value)
            or '\\' in value):
        raise ValueError('Evidence URL must be HTTP(S) or a root-relative application URL.')
    parts = urlsplit(value)
    if value.startswith('/') and not value.startswith('//') and not parts.scheme and not parts.netloc:
        return
    if parts.scheme in ('http', 'https') and parts.hostname and not parts.username and not parts.password:
        return
    raise ValueError('Evidence URL must be HTTP(S) or a root-relative application URL.')


def _resolution_proof(db, flow_id, issue_id, result, root):
    """Require a focused replay of the original failing criterion."""
    issue = db.execute('''SELECT a.flow_id,i.criterion_id,i.affected_sources_json
        FROM virtual_workflow_issues i JOIN virtual_workflow_attempts a
        ON a.attempt_id=i.attempt_id WHERE i.issue_id=?''', (issue_id,)).fetchone()
    if not issue or issue[0] != flow_id:
        raise ValueError('Issue resolution must reference an existing issue in the same flow.')
    if result.get('test_status') not in ('passed', 'scoped_pass'):
        raise ValueError('Issue resolution requires a successful rerun.')
    proof = result.get('issue_resolution_results', {}).get(str(issue_id), {})
    criterion = issue[1]
    if (proof.get('criterion_id') != criterion or proof.get('result') != 'passed'
            or proof.get('reproduction_verified') is not True):
        raise ValueError('Issue resolution must explicitly replay and pass its original criterion.')
    if any(item.get('criterion_id') == criterion for item in result.get('issues', [])):
        raise ValueError('A criterion cannot be resolved and reported failing in the same attempt.')
    affected = set(json.loads(issue[2]))
    sources = result.get('source_bindings', {})
    if not affected.issubset(sources) or not _bindings_current(sources, root):
        raise ValueError('Resolution must bind every original affected source at its current revision.')
    evidence = {item['path']: item for item in result.get('evidence', [])}
    if not evidence or any(not _bindings_current({name: item.get('sha256')}, root)
                           for name, item in evidence.items()):
        raise ValueError('Resolution evidence is missing or stale.')
    name = proof.get('evidence_path')
    if name not in evidence:
        raise ValueError('Focused resolution receipt must be included in current bound evidence.')
    try:
        receipt = json.loads(_path(root, name).read_text())
    except (OSError, ValueError, UnicodeError) as exc:
        raise ValueError('Focused resolution receipt is not valid readable JSON.') from exc
    criteria = receipt.get('criterion_results', {}) if isinstance(receipt, dict) else {}
    if not isinstance(criteria, dict) or criteria.get(criterion) != 'passed':
        raise ValueError('Focused receipt does not prove the original criterion passed.')


def _resolution_current(db, flow_id, issue_id, root):
    row = db.execute('''SELECT a.definition_sha256,a.result_json FROM virtual_workflow_issue_resolutions r
        JOIN virtual_workflow_attempts a ON a.attempt_id=r.attempt_id
        WHERE r.issue_id=? ORDER BY r.attempt_id DESC LIMIT 1''', (issue_id,)).fetchone()
    if not row:
        return False
    try:
        _, current_sha = _flow(db, flow_id)
        if row[0] != current_sha:
            return False
        _resolution_proof(db, flow_id, issue_id, json.loads(row[1]), root)
    except (ValueError, KeyError, TypeError, OSError):
        return False
    return True


def _open_issues(db, flow_id, root):
    return [issue_id for (issue_id,) in db.execute('''SELECT i.issue_id FROM virtual_workflow_issues i
        JOIN virtual_workflow_attempts a ON a.attempt_id=i.attempt_id WHERE a.flow_id=?''', (flow_id,))
        if not _resolution_current(db, flow_id, issue_id, root)]


def _verified_proof(flow_id, definition, definition_sha, result, root):
    """Fail closed; no status flag can substitute for complete current receipts."""
    if result['scope'] != 'workflow' or result['test_status'] != 'passed':
        raise ValueError('Verified requires a passed full workflow attempt.')
    if result.get('issues') or result.get('blockers'):
        raise ValueError('Verified cannot retain unresolved issues or blockers.')
    gates = result.get('gate_record', {})
    evaluation = evaluate(gates, root)
    if gates.get('workflow_id') != flow_id or not evaluation['green']:
        raise ValueError('Verified requires all seven current workflow gates.')
    if any(definition_sha not in gate.get('specifications', {}).values()
           for gate in gates['gates'].values()):
        raise ValueError('Each gate must bind the exact current database definition artifact.')
    expected_ids = set(acceptance_ids(definition))
    evidence = {e['path']: e for e in result['evidence']}
    review_path, receipt_path = result.get('acceptance_review_path'), result.get('workflow_receipt_path')
    if review_path not in evidence or receipt_path not in evidence:
        raise ValueError('Review and workflow receipt must be hash-bound evidence.')
    review = json.loads(_path(root, review_path).read_text())
    receipt = json.loads(_path(root, receipt_path).read_text())
    for item in (review, receipt):
        if item.get('workflow_id') != flow_id or item.get('definition_sha256') != definition_sha:
            raise ValueError('Review/receipt is for a different workflow or definition.')
    if (not review.get('reviewed_by') or not review.get('approval_id')
            or review['approval_id'] != gates['gates']['review'].get('approval_id')
            or set(review.get('acceptance_ids', [])) != expected_ids):
        raise ValueError('Review must explicitly approve every current acceptance criterion.')
    if gates['gates']['review'].get('artifacts', {}).get(review_path) != evidence[review_path]['sha256']:
        raise ValueError('Review gate must bind the acceptance review artifact.')
    if gates['gates']['behavior'].get('artifacts', {}).get(receipt_path) != evidence[receipt_path]['sha256']:
        raise ValueError('Behavior gate must bind the executed workflow receipt.')
    if (receipt.get('scope') != 'workflow' or receipt.get('result') != 'passed'
            or not receipt.get('run_id') or not receipt.get('runner')
            or not receipt.get('started_at') or not receipt.get('finished_at')
            or receipt.get('login_method') != 'credentials'
            or receipt.get('isolated_database') is not True
            or receipt.get('reload_confirmed') is not True
            or receipt.get('source_bindings') != result['source_bindings']
            or receipt.get('acceptance_results') != {key: 'passed' for key in expected_ids}):
        raise ValueError('Workflow receipt lacks executed, current acceptance results.')
    declared_sources = set(definition.get('source_paths', []))
    if not declared_sources or not declared_sources.issubset(result['source_bindings']):
        raise ValueError('All declared workflow source files must be current and bound.')
    required_kinds = {'browser', 'api', 'database', 'security', 'video'}
    artifacts = receipt.get('artifacts', [])
    if not required_kinds.issubset({item.get('kind') for item in artifacts}):
        raise ValueError('Receipt requires browser/API/database/security/video artifacts.')
    for artifact in artifacts:
        bound = evidence.get(artifact.get('path'))
        if not bound or bound['sha256'] != artifact.get('sha256') or bound['kind'] != artifact.get('kind'):
            raise ValueError('Workflow receipt artifact is missing or not bound to evidence.')
    return evaluation


def record_attempt(db, flow_id, result, source_root=ROOT):
    """Record one attempt atomically. Returns attempt ID and live status counts.

    Nonverified result keys: status, test_status, scope, next_action,
    source_bindings, evidence, issues, blockers. Each issue supplies criterion_id,
    reproduction, expected, actual, affected_sources. Each evidence item supplies
    relative path, sha256, kind and optional durable URL. At least one current
    artifact is required for any claimed pass. No review is required for a
    scoped, failed, missing or blocked attempt.

    Optional existing_issue_ids references open same-flow reports during a
    recheck without inserting duplicate issues. Current evidence and bindings
    for every original affected source are required. Referencing is not closure.

    Optional resolves_issue_ids plus resolution_note and issue_resolution_results
    link a successful focused rerun to existing same-flow issues. Each keyed
    result supplies criterion_id, result='passed', reproduction_verified=true,
    and evidence_path to a bound JSON receipt with criterion_results[id]='passed'.
    This preserves original reports and does not promote workflow status. Stale
    source/spec/evidence invalidates closure until a new focused rerun is saved.
    """
    prepare(db)
    root = Path(source_root).resolve()
    definition, definition_sha = _flow(db, flow_id)
    status = result.get('status')
    if status not in STATUSES or result.get('test_status') not in TEST_STATUSES:
        raise ValueError('Invalid verification status or test status.')
    if result.get('scope') not in ('scoped', 'workflow'):
        raise ValueError('Scope must be scoped or workflow.')
    _required_text(result.get('next_action'), 'next_action')
    sources = result.get('source_bindings', {})
    if not _bindings_current(sources, root):
        raise ValueError('Source bindings are absent, unsafe, missing or stale.')
    issues = result.get('issues', [])
    for issue in issues:
        for key in ('criterion_id', 'reproduction', 'expected', 'actual'):
            _required_text(issue.get(key), 'issue.' + key)
        if not isinstance(issue.get('affected_sources'), list) or not issue['affected_sources']:
            raise ValueError('Issue must identify affected source paths.')
        for name in issue['affected_sources']:
            _path(root, name)
    existing = result.get('existing_issue_ids', [])
    if (not isinstance(existing, list)
            or any(type(issue_id) is not int or issue_id < 1 for issue_id in existing)
            or len(set(existing)) != len(existing)):
        raise ValueError('existing_issue_ids must contain distinct positive issue IDs.')
    for issue_id in existing:
        issue = db.execute('''SELECT a.flow_id,i.affected_sources_json FROM virtual_workflow_issues i
            JOIN virtual_workflow_attempts a ON a.attempt_id=i.attempt_id WHERE i.issue_id=?''', (issue_id,)).fetchone()
        if not issue or issue[0] != flow_id:
            raise ValueError('Existing issue must belong to this workflow.')
        if not set(json.loads(issue[1])).issubset(sources):
            raise ValueError('Rechecking an issue requires current bindings for all original affected sources.')
        if _resolution_current(db, flow_id, issue_id, root):
            raise ValueError('Existing issue is currently resolved; record a new regression issue instead.')
    if result['test_status'] == 'failed' and not (issues or existing):
        raise ValueError('A failed attempt must record a reproducible issue.')
    if status == 'missing' and not (issues or existing):
        raise ValueError('Missing functionality must have a recorded issue.')
    blockers = result.get('blockers', [])
    if not isinstance(blockers, list) or any(not isinstance(x, str) or not x.strip() for x in blockers):
        raise ValueError('Blockers must be a list of nonempty reasons.')
    if status == 'blocked' and not blockers:
        raise ValueError('Blocked status requires an exact blocker.')
    evidence = result.get('evidence', [])
    if not isinstance(evidence, list):
        raise ValueError('Evidence must be a list.')
    seen = set()
    for item in evidence:
        name = item.get('path')
        _required_text(item.get('kind'), 'evidence.kind')
        if name in seen or not _bindings_current({name: item.get('sha256')}, root):
            raise ValueError('Evidence is duplicate, unsafe, missing or stale.')
        _evidence_url(item.get('url'))
        seen.add(name)
    if result['test_status'] in ('passed', 'scoped_pass') and not evidence:
        raise ValueError('A passing result requires a current execution artifact.')
    if existing and not evidence:
        raise ValueError('Rechecking an existing issue requires current bound evidence.')
    resolves = result.get('resolves_issue_ids', [])
    if (not isinstance(resolves, list)
            or any(type(issue_id) is not int or issue_id < 1 for issue_id in resolves)
            or len(set(resolves)) != len(resolves)):
        raise ValueError('resolves_issue_ids must contain distinct positive issue IDs.')
    if set(existing).intersection(resolves):
        raise ValueError('An issue cannot be rechecked as open and resolved in the same attempt.')
    resolution_results = result.get('issue_resolution_results', {})
    if not isinstance(resolution_results, dict) or set(resolution_results) != {str(issue_id) for issue_id in resolves}:
        raise ValueError('issue_resolution_results must match the resolved issue IDs exactly.')
    if resolves:
        _required_text(result.get('resolution_note'), 'resolution_note')
        if result['test_status'] not in ('passed', 'scoped_pass') or not evidence:
            raise ValueError('Issue resolution requires successful current rerun evidence.')
        for issue_id in resolves:
            _resolution_proof(db, flow_id, issue_id, result, root)
            if _resolution_current(db, flow_id, issue_id, root):
                raise ValueError('Issue already has a current recorded resolution.')
    if status == 'verified':
        if any(issue_id not in resolves for issue_id in _open_issues(db, flow_id, root)):
            raise ValueError('Verified requires current focused resolution of every recorded open issue.')
    gate_result = _verified_proof(flow_id, definition, definition_sha, result, root) if status == 'verified' else None
    # Status is explicit. Recording a narrower later attempt conservatively
    # downgrades completion while preserving the prior full receipt in history.
    if not db.in_transaction:
        db.execute('BEGIN')
    db.execute('SAVEPOINT workflow_attempt')
    try:
        cur = db.execute('''INSERT INTO virtual_workflow_attempts(flow_id,definition_sha256,
          requested_status,test_status,scope,source_bindings_json,gate_result_json,result_json)
          VALUES(?,?,?,?,?,?,?,?)''', (flow_id, definition_sha, status, result['test_status'],
          result['scope'], encoded(sources), encoded(gate_result) if gate_result else None, encoded(result)))
        attempt_id = cur.lastrowid
        for issue in issues:
            db.execute('''INSERT INTO virtual_workflow_issues(attempt_id,criterion_id,reproduction,
              expected_text,actual_text,affected_sources_json) VALUES(?,?,?,?,?,?)''',
              (attempt_id, issue['criterion_id'], issue['reproduction'], issue['expected'],
               issue['actual'], encoded(issue['affected_sources'])))
        for item in evidence:
            db.execute('''INSERT INTO virtual_workflow_evidence(attempt_id,kind,path,sha256,url)
              VALUES(?,?,?,?,?)''', (attempt_id, item['kind'], item['path'], item['sha256'], item.get('url')))
        db.executemany('''INSERT INTO virtual_workflow_issue_resolutions(issue_id,attempt_id,resolution_note)
            VALUES(?,?,?)''', [(issue_id, attempt_id, result['resolution_note']) for issue_id in resolves])
        db.execute('''UPDATE virtual_workflow_definitions SET verification_status=?,
          test_status=?,blocker_json=?,updated_at=CURRENT_TIMESTAMP WHERE flow_id=?''',
          (status, result['test_status'], encoded(blockers), flow_id))
        db.execute('''INSERT INTO virtual_workflow_checkpoints(flow_id,attempt_id,next_action)
          VALUES(?,?,?) ON CONFLICT(flow_id) DO UPDATE SET attempt_id=excluded.attempt_id,
          next_action=excluded.next_action,invalidation_json='[]',updated_at=CURRENT_TIMESTAMP''',
          (flow_id, attempt_id, result['next_action']))
        db.execute('RELEASE workflow_attempt')
    except Exception:
        db.execute('ROLLBACK TO workflow_attempt')
        db.execute('RELEASE workflow_attempt')
        raise
    return {'workflow_id': flow_id, 'attempt_id': attempt_id, 'status': status, 'summary': summary(db)}


def refresh(db, source_root=ROOT):
    """Downgrade stale receipts without deleting historical evidence/attempts."""
    prepare(db)
    root = Path(source_root).resolve()
    changed = []
    rows = db.execute('''SELECT c.flow_id,c.attempt_id,a.definition_sha256,
      a.source_bindings_json,a.result_json FROM virtual_workflow_checkpoints c
      JOIN virtual_workflow_attempts a ON a.attempt_id=c.attempt_id''').fetchall()
    for flow_id, attempt_id, old_definition, sources_json, result_json in rows:
        reasons = []
        current_sha = None
        try:
            definition, current_sha = _flow(db, flow_id)
            if current_sha != old_definition:
                reasons.append('Workflow definition changed; acceptance review/execution must be refreshed.')
        except ValueError as exc:
            reasons.append(str(exc))
        result = json.loads(result_json)
        if not _bindings_current(json.loads(sources_json), root):
            reasons.append('Source binding is missing, unsafe or stale.')
        for name, expected in db.execute('SELECT path,sha256 FROM virtual_workflow_evidence WHERE attempt_id=?', (attempt_id,)):
            if not _bindings_current({name: expected}, root):
                reasons.append('Evidence binding is missing, unsafe or stale: ' + name)
        if not reasons and result.get('status') == 'verified':
            try:
                _verified_proof(flow_id, definition, current_sha, result, root)
                if _open_issues(db, flow_id, root):
                    raise ValueError('A recorded issue resolution is missing or stale.')
            except (ValueError, KeyError, OSError, TypeError) as exc:
                reasons.append('Full verification proof is no longer valid: ' + str(exc))
        if reasons:
            # A changed definition needs renewed requirements review. A changed
            # source/artifact leaves implementation present but unverified.
            status = 'blocked' if old_definition != current_sha else 'implemented-unverified'
            db.execute('''UPDATE virtual_workflow_definitions SET verification_status=?,
              test_status='stale',blocker_json=?,updated_at=CURRENT_TIMESTAMP WHERE flow_id=?''',
              (status, encoded(reasons), flow_id))
            db.execute('''UPDATE virtual_workflow_checkpoints SET invalidation_json=?,
              updated_at=CURRENT_TIMESTAMP WHERE flow_id=?''', (encoded(reasons), flow_id))
            changed.append({'workflow_id': flow_id, 'status': status, 'reasons': reasons})
    return {'invalidated': changed, 'summary': summary(db)}


def summary(db):
    counts = {status: 0 for status in STATUSES}
    for status, count in db.execute('''SELECT verification_status,COUNT(*)
      FROM virtual_workflow_definitions WHERE flow_kind='business_process'
      GROUP BY verification_status'''):
        if status not in counts:
            raise ValueError('Unknown workflow status: ' + str(status))
        counts[status] = count
    return {'total': sum(counts.values()), **counts, 'done': counts['verified'],
            'pending': sum(counts.values()) - counts['verified']}



def export_progress(db, root):
    result = {'scope': 'business_process only; supporting guides excluded', 'summary': summary(db)}
    columns = ['workflow_id','title','status','test_status','blockers','next_action','attempt_id']
    rows = db.execute("""SELECT d.flow_id,d.title,d.verification_status,d.test_status,
        d.blocker_json,c.next_action,c.attempt_id FROM virtual_workflow_definitions d
        LEFT JOIN virtual_workflow_checkpoints c ON c.flow_id=d.flow_id
        WHERE d.flow_kind='business_process' ORDER BY d.flow_id""").fetchall()
    result['workflows'] = [dict(zip(columns, row)) for row in rows]
    issues = db.execute('SELECT COUNT(*) FROM virtual_workflow_issues').fetchone()[0]
    unresolved = sum(len(_open_issues(db, row[0], root)) for row in rows)
    result['issues'] = {'recorded': issues, 'resolved_current': issues-unresolved, 'open': unresolved}
    target = root / 'docs/task-progress'
    target.mkdir(parents=True, exist_ok=True)
    (target/'workflow-execution-status.json').write_text(json.dumps(result,indent=2)+'\n')
    lines = ['# Business workflow execution status', '',
        'Only a verified workflow receives a completion tick. Source audits and scoped tests do not complete a workflow.', '',
        '| Total | Missing | Implemented-unverified | Verified | Blocked |',
        '| ---: | ---: | ---: | ---: | ---: |']
    counts = result['summary']
    lines.append('| '+' | '.join(str(counts[key]) for key in ['total','missing','implemented-unverified','verified','blocked'])+' |')
    lines += ['', '| Done | Workflow | Status | Test scope/status | Next action |', '| --- | --- | --- | --- | --- |']
    for row in result['workflows']:
        values = [('✓' if row['status']=='verified' else '☐'),row['workflow_id'],row['status'],row['test_status'],row['next_action'] or 'Review definition and recorded blockers.']
        lines.append('| '+' | '.join(str(value).replace('|','\\|').replace('\n',' ') for value in values)+' |')
    (target/'WORKFLOW_EXECUTION_STATUS.md').write_text('\n'.join(lines)+'\n')
    db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP', ('execution-current',encoded(result)))
    return result['summary']


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--db', type=Path, help='Explicit isolated SQLite fixture only; default is pinned production PostgreSQL')
    parser.add_argument('--root', type=Path, default=ROOT)
    parser.add_argument('--attempt', type=Path, help='JSON with workflow_id and result fields described by record_attempt.')
    parser.add_argument('--refresh', action='store_true')
    parser.add_argument('--export', action='store_true', help='Save current business workflow status and resumable next actions')
    args = parser.parse_args()
    if args.db is not None:
        import os
        if (os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES') != '1'
                or os.environ.get('GOVERNANCE_DATABASE_URL')
                or os.environ.get('PRODUCTION_DATABASE_URL')):
            parser.error('--db requires isolated fixture mode without production credentials')
        if not args.db.is_file():
            parser.error('Database does not exist; refusing to create an empty governance database.')
        store = sqlite3.connect(args.db)
    else:
        from production_store import ProductionWorkflowStore
        store = ProductionWorkflowStore()
    with store as db:
        prepare(db)
        output = {}
        if args.refresh:
            output['refresh'] = refresh(db, args.root)
        if args.attempt:
            result = json.loads(args.attempt.read_text())
            output['attempt'] = record_attempt(db, result['workflow_id'], result, args.root)
        if args.export:
            output['export'] = export_progress(db, args.root.resolve())
        output['summary'] = summary(db)
        print(json.dumps(output, indent=2))


if __name__ == '__main__':
    main()
