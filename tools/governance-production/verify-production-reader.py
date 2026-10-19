import json,pathlib
from production_reader import connect
with connect() as db:
 counts={name:db.execute('SELECT COUNT(*) FROM '+name).fetchone()[0] for name in ['roles','screens','virtual_workflow_definitions','virtual_workflow_steps','virtual_workflow_source_links','virtual_role_flow_guides','virtual_flow_catalog_snapshots','project_file_registry','project_file_dependencies','implementation_execution_plan','screen_diagnosis_tests','screen_implementation_tasks']}
 processes=db.execute("SELECT COUNT(*) FROM virtual_workflow_definitions WHERE flow_kind=?",('business_process',)).fetchone()[0]
 statuses={row[0]:row[1] for row in db.execute("SELECT verification_status, COUNT(*) FROM virtual_workflow_definitions WHERE flow_kind=? GROUP BY verification_status",('business_process',))}
 print(json.dumps({'verifiedProductionRead':True,'pin':json.loads((pathlib.Path(__file__).parent/'production-pin.json').read_text()),'counts':counts,'businessProcesses':processes,'verificationStatuses':statuses,'writesAttempted':False}))
