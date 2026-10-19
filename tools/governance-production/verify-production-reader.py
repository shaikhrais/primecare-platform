import json,pathlib
from production_reader import connect
with connect() as db:
 counts={name:db.execute('SELECT COUNT(*) FROM '+name).fetchone()[0] for name in ['roles','screens','virtual_workflow_definitions','virtual_workflow_steps','virtual_workflow_source_links','virtual_role_flow_guides','virtual_flow_catalog_snapshots']}
 processes=db.execute("SELECT COUNT(*) FROM virtual_workflow_definitions WHERE flow_kind=?",('business_process',)).fetchone()[0]
 print(json.dumps({'verifiedProductionRead':True,'pin':json.loads((pathlib.Path(__file__).parent/'production-pin.json').read_text()),'counts':counts,'businessProcesses':processes,'writesAttempted':False}))
