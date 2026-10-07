"""Repair the repository's derived SQLite catalog before generating artifacts.

Each quarantine is independently atomic and retains source evidence. A failed
integrity check stops generation; this tool never invents business authority.
"""
import argparse,importlib.util,json,sqlite3
from pathlib import Path
from api_authority_integrity import assert_api_authority_integrity
from governance_schema_integrity import quarantine_generated_schemas

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('grant_quarantine',ROOT/'scripts/quarantine-api-grants.py')
grants=importlib.util.module_from_spec(spec);spec.loader.exec_module(grants)

def repair(path):
    path=Path(path).resolve()
    if not path.is_file():raise ValueError('Explicit existing local SQLite catalog required')
    grants.consumer_preflight(ROOT)
    with sqlite3.connect(path) as db:
        db.row_factory=sqlite3.Row
        plan,_=grants.preflight(db)
        permissions=grants.apply(db,plan['planDigest']) if plan['candidateRows'] else {'quarantinedRows':0,'remainingGrantRows':sum(plan['classifications'].values())}
        schemas=quarantine_generated_schemas(db);db.commit()
        assert_api_authority_integrity(db)
        return {'scope':'local_derived_governance_catalog','permissionRowsQuarantined':permissions['quarantinedRows'],
                'schemaRowsQuarantined':schemas,'authorityIntegrity':'passed','newCompletedOperations':0}

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('database',type=Path);args=parser.parse_args()
    print(json.dumps(repair(args.database),sort_keys=True))
