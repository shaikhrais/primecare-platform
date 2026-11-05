#!/usr/bin/env python3
"""Read only screen/role grant metadata for the unresolved governance paths.

The production entry point uses the repository's pinned read-only governance
reader. It never reads users, patients or business records and has no writes.
Similar names do not establish aliases or grant access.
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PATHS = (
    '/admin/reality-check', '/admin/role-screen-carousel', '/admin/screenshot-gallery',
    '/generated/corporate/ceo/growth-pipeline',
    '/generated/corporate/ceo/region-performance',
    '/generated/corporate/ceo/leadership-reports',
    '/offices/corporate/roles/ceo/growth-pipeline',
    '/offices/corporate/roles/ceo/region-performance',
    '/offices/corporate/roles/ceo/leadership-reports',
    '/generated/offices/corporate/roles/ceo/growth-pipeline',
    '/generated/offices/corporate/roles/ceo/region-performance',
    '/generated/offices/corporate/roles/ceo/leadership-reports',
)
CODES = ('admin_reality_check', 'admin_role_screen_carousel', 'admin_screenshot_gallery')


def collect(db):
    path_slots = ','.join('?' for _ in PATHS)
    code_slots = ','.join('?' for _ in CODES)
    sql = f'''SELECT s.screen_code, s.route_path, r.role_code, p.can_view
      FROM screens s LEFT JOIN role_screen_permissions p ON p.screen_id=s.id
      LEFT JOIN roles r ON r.id=p.role_id
      WHERE s.route_path IN ({path_slots}) OR s.screen_code IN ({code_slots})
      ORDER BY s.route_path, s.screen_code, r.role_code'''
    rows = db.execute(sql, PATHS + CODES).fetchall()
    return [dict(zip(('screen_code', 'route_path', 'role_code', 'can_view'), row)) for row in rows]


def main():
    sys.path.insert(0, str(ROOT / 'tools/governance-production'))
    from production_reader import connect
    with connect() as db:
        rows = collect(db)
    print(json.dumps({'readOnly': True, 'screenRoleMetadataOnly': True, 'rows': rows}, default=str))


if __name__ == '__main__':
    main()
