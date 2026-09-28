"""Store a reviewable reporting proposal, never effective permission grants."""
import argparse
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
# Recommended administrative reporting lines, NOT established company facts.
GROUPS = {
    'ceo': ['cfo', 'ciso', 'coo', 'cto', 'hr_director', 'legal', 'bus_dev', 'marketing', 'governance'],
    'coo': ['clinical_director', 'cx_director', 'training_director', 'gm', 'regional_manager_usa', 'franchise_sales'],
    'cfo': ['finance_director'],
    'ciso': ['infrastructure'],
    'cto': ['system_verification', 'scrum_master'],
    'governance': ['compliance'],
    'compliance': ['qa_specialist'],
    'hr_director': ['hr_hiring'],
    'bus_dev': ['partnership', 'regional_bdm', 'territory_expansion'],
    'regional_bdm': ['territory_sales'],
    'marketing': ['community_outreach', 'local_marketing'],
    'gm': ['ops_manager', 'admin'],
    'ops_manager': ['scheduler', 'volunteer_coordinator'],
    'volunteer_coordinator': ['volunteer'],
    'cx_director': ['customer_support', 'premium_concierge', 'vip_manager'],
    'training_director': ['training_coordinator'],
    'clinical_director': ['chiropractor', 'physio', 'rmt', 'social_worker', 'therapist', 'intake',
                          'physician', 'cns', 'pediatric', 'rn_field_supervisor', 'np'],
    'rn_field_supervisor': ['rn', 'rpn', 'lpn', 'psw', 'hsw', 'caregiver'],
}
UNRESOLVED = {
    'ceo': 'Top executive in this proposal; board/ownership oversight is not defined in registered roles.',
    'owner': 'Franchise Owner: separate tenant/ownership relationship; no corporate reporting line assumed.',
    'shareholder': 'Ownership interest does not establish operational management or data access.',
    'guest': 'External/non-staff classification requires correction review; no employee manager assigned.',
    'portal': 'Generic portal identity; no employee manager assumed.',
    'patient': 'Care recipient; not an employee subordinate.',
    'family': 'Family relationship requires patient consent rules; not an employee subordinate.',
    'dynamic': 'Technical viewer role; business reporting relationship is unspecified.',
    'training': 'Candidate supervision depends on placement and approved training arrangements.',
    'employee': 'Generic employee requires an explicit department and manager assignment.',
}


def validate(codes):
    edges = {child: parent for parent, children in GROUPS.items() for child in children}
    children = [child for group in GROUPS.values() for child in group]
    if len(children) != len(set(children)):
        raise ValueError('Duplicate reporting assignment')
    if set(edges) & set(UNRESOLVED) or set(edges) | set(UNRESOLVED) != set(codes):
        raise ValueError('Proposal must cover exactly the existing active roles')
    if not set(edges.values()) <= set(codes):
        raise ValueError('Unknown supervisor role')
    for child in edges:
        seen = set()
        current = child
        while current in edges:
            if current in seen:
                raise ValueError('Reporting cycle')
            seen.add(current)
            current = edges[current]
    return edges


def migrate(db):
    roles = dict(db.execute('SELECT role_code, id FROM roles WHERE active = 1'))
    edges = validate(roles)
    with db:
        db.execute('''CREATE TABLE IF NOT EXISTS authority_hierarchy_proposals (
          proposal_code TEXT NOT NULL,
          role_id INTEGER NOT NULL REFERENCES roles(id),
          proposed_supervisor_role_id INTEGER REFERENCES roles(id),
          relationship_type TEXT NOT NULL CHECK(relationship_type IN ('administrative_reporting','unresolved')),
          scope TEXT NOT NULL CHECK(scope = 'same_organization_and_tenant_only'),
          status TEXT NOT NULL CHECK(status = 'proposed'),
          inherits_permissions INTEGER NOT NULL CHECK(inherits_permissions = 0),
          rationale TEXT NOT NULL,
          PRIMARY KEY(proposal_code, role_id),
          CHECK(role_id != proposed_supervisor_role_id))''')
        for code, role_id in roles.items():
            manager = edges.get(code)
            db.execute('''INSERT INTO authority_hierarchy_proposals VALUES (?, ?, ?, ?, ?, ?, ?, ?)
              ON CONFLICT(proposal_code, role_id) DO NOTHING''', (
                'AUTHORITY_REVIEW_20260928', role_id, roles[manager] if manager else None,
                'administrative_reporting' if manager else 'unresolved',
                'same_organization_and_tenant_only', 'proposed', 0,
                'Recommended administrative reporting only; confirm against organization requirements. '
                'Does not authorize clinical practice, user creation, role assignment, or access to subordinate data.'
                if manager else UNRESOLVED[code]))
    return len(roles)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--apply', action='store_true')
    parser.add_argument('--approve', action='store_true', help='Record user approval of reporting lines only.')
    args = parser.parse_args()
    path = ROOT / '.agents/governance/governance.db'
    with sqlite3.connect(path.resolve().as_uri() + '?mode=ro', uri=True) as source:
        roles = dict(source.execute('SELECT role_code, id FROM roles WHERE active = 1'))
        edges = validate(roles)
        if args.apply:
            backup = path.with_name('governance.before-authority-proposal.db')
            if not backup.exists():
                with sqlite3.connect(backup) as target:
                    source.backup(target)
    if args.approve and not args.apply:
        parser.error('--approve requires --apply')
    if args.apply:
        with sqlite3.connect(path) as db:
            db.execute('PRAGMA foreign_keys=ON')
            migrate(db)
            if args.approve:
                with db:
                    db.execute('''CREATE TABLE IF NOT EXISTS authority_hierarchy_approvals (
                      proposal_code TEXT PRIMARY KEY,
                      approved_scope TEXT NOT NULL CHECK(approved_scope = 'administrative_reporting_only'),
                      approval_source TEXT NOT NULL,
                      grants_permissions INTEGER NOT NULL CHECK(grants_permissions = 0))''')
                    db.execute('''INSERT INTO authority_hierarchy_approvals VALUES (?, ?, ?, 0)
                      ON CONFLICT(proposal_code) DO NOTHING''', (
                        'AUTHORITY_REVIEW_20260928', 'administrative_reporting_only',
                        'User confirmation in project conversation, 2026-09-28 12:31 America/Toronto'))
                print('Recorded approval: administrative reporting only; unresolved relationships remain unresolved.')
    print(f"{'Stored' if args.apply else 'Validated'} {len(roles)} proposed roles: "
          f'{len(edges)} reporting lines, {len(UNRESOLVED)} unresolved/top-level roles; zero permission grants.')


if __name__ == '__main__':
    main()
