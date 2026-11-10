"""Add the known Code Admin role to an explicit historical CI fixture only."""
import os
import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def prepare(root=ROOT):
    if (os.environ.get('CI') != 'true'
            or os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES') != '1'
            or any(os.environ.get(k) for k in ('PRODUCTION_DATABASE_URL', 'GOVERNANCE_DATABASE_URL'))):
        raise RuntimeError('Explicit isolated CI fixture required')
    path = Path(root) / '.agents/governance/governance.db'
    if not path.is_file() or any(p.is_symlink() for p in (path, *path.parents)):
        raise RuntimeError('Existing regular historical fixture required')
    # mode=rw prevents SQLite from creating an accidental empty authority.
    with sqlite3.connect(path.as_uri() + '?mode=rw', uri=True) as db:
        db.execute("INSERT INTO roles(role_code,role_name,role_type,active,primary_app_code,post_login_route) SELECT 'code_admin','Code Administrator','Infrastructure',1,'go','/platform/administration' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE role_code='code_admin')")
    return {'scope': 'isolated-historical-fixture', 'productionWrites': False}


if __name__ == '__main__':
    prepare()
    print('Code Admin role prepared in isolated fixture; no production connection or account changes')
