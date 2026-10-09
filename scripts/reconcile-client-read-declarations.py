"""Retire two unused legacy POST declarations in favor of governed owner GETs.
Run after canonical client-self registration; idempotent and refuses linked callers.
"""
import json, sqlite3
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
RETIREMENTS = [(235, '/v1/client/home/profile'), (239, '/v1/client/invoices')]

def reconcile(db):
    for legacy_id, path in RETIREMENTS:
        canonical = db.execute("SELECT id,service_name,auth_required,permission_key,request_schema,response_schema FROM api_endpoints WHERE route_path=? AND http_method='GET'", (path,)).fetchall()
        if len(canonical) != 1 or canonical[0][1:4] != ('client',1,'authenticated_client_profile_owner'):
            raise ValueError('Canonical governed owner read missing: ' + path)
        try:
            if not all(isinstance(json.loads(value),dict) and json.loads(value) for value in canonical[0][4:]):
                raise ValueError('Empty canonical schema')
        except (TypeError,ValueError) as error:
            raise ValueError('Canonical schema missing or malformed: '+path) from error
        legacy = db.execute('SELECT route_path,http_method FROM api_endpoints WHERE id=?', (legacy_id,)).fetchone()
        if legacy is None:
            continue
        if legacy != (path, 'POST'):
            raise ValueError('Legacy declaration identity changed')
        for table in ['screen_api_links', 'screen_api_map']:
            if db.execute('SELECT 1 FROM ' + table + ' WHERE api_id=? LIMIT 1', (legacy_id,)).fetchone():
                raise ValueError('Legacy declaration has a registered caller: ' + path)
        # Keep a tombstone so existing foreign-key references never become dangling.
        db.execute("UPDATE api_endpoints SET implementation_status='retired',health_status='unverified' WHERE id=?", (legacy_id,))

if __name__ == '__main__':
    with sqlite3.connect(ROOT / '.agents/governance/governance.db') as db:
        reconcile(db)
    print('Retired 2 unused POST declarations; existing GET authority and runtime unchanged.')
