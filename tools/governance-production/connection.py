"""Shared governance authority; SQLite is permitted only as an explicit test fixture."""
import os, pathlib, sqlite3

def connect(database=None,*args,**kwargs):
    if os.environ.get('GOVERNANCE_ALLOW_SQLITE_FIXTURES')=='1':
        if os.environ.get('GOVERNANCE_DATABASE_URL') or os.environ.get('PRODUCTION_DATABASE_URL'):
            raise RuntimeError('SQLite fixtures cannot be enabled with production credentials')
        fixture=database or pathlib.Path(__file__).resolve().parents[2]/'.agents/governance/governance.db'
        return sqlite3.connect(fixture,*args,**kwargs)
    if database is not None:
        raise RuntimeError('Legacy governance file arguments require explicit isolated fixture mode')
    from production_reader import connect as production_connect
    return production_connect()
