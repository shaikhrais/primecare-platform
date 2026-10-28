"""Verify the complete generated growth policy using disposable metadata only."""
import json
import os
from pathlib import Path
import runpy
import sqlite3

ROOT = Path(__file__).resolve().parents[1]
if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES') != '1':
    raise RuntimeError('Explicit isolated metadata fixture required')
if any(os.environ.get(key) for key in ('PRODUCTION_DATABASE_URL', 'GOVERNANCE_DATABASE_URL')):
    raise RuntimeError('Production credentials forbidden in fixture verification')
with sqlite3.connect((ROOT / '.agents/governance/governance.db').as_uri() + '?mode=ro', uri=True) as source:
    with sqlite3.connect(':memory:') as db:
        source.backup(db)
        db.execute("INSERT OR IGNORE INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) VALUES('code_admin','Code Administrator','Infrastructure',1,'go','/platform/administration')")
        growth = runpy.run_path(str(ROOT / 'scripts/register-growth-governance.py'))['register']
        growth(db)
        # Media registration inherits the growth theme before its shared tokens
        # are included by the final export. Preserve this dependency order.
        runpy.run_path(str(ROOT / 'scripts/register-media-look.py'))['register'](db)
        actual = growth(db)
        expected = json.loads((ROOT / 'packages/shared/src/growth/registry.json').read_text())
        assert actual == expected, 'Generated growth policy differs from registered metadata'
print('Complete growth policy export verified; fixture source unchanged; no production authority.')
