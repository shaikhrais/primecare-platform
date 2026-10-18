"""Write source-derived virtual process plans. Never execute or verify business workflows."""
import hashlib
import json
import sqlite3
import re
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
PLAN_DIR = Path(__file__).with_name('virtual-processes')


def encoded(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True)


def rows(db, table):
    return [dict(r) for r in db.execute('SELECT * FROM "' + table + '"')]


def prepare(db):
    db.executescript('''
    CREATE TABLE IF NOT EXISTS virtual_workflow_definitions(
      flow_id TEXT PRIMARY KEY, flow_kind TEXT NOT NULL CHECK(flow_kind IN
        ('business_process','screen_journey','action_journey','api_contract','legacy_candidate')),
      title TEXT NOT NULL, actor_roles_json TEXT NOT NULL, trigger_text TEXT NOT NULL,
      preconditions_json TEXT NOT NULL, outcome_text TEXT NOT NULL,
      definition_json TEXT NOT NULL, definition_sha256 TEXT NOT NULL,
      definition_status TEXT NOT NULL CHECK(definition_status IN ('virtual_draft','source_mapped')),
      verification_status TEXT NOT NULL DEFAULT 'blocked' CHECK(verification_status IN
        ('missing','implemented-unverified','verified','blocked')),
      blocker_json TEXT NOT NULL, test_status TEXT NOT NULL DEFAULT 'not_run',
      created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    CREATE TABLE IF NOT EXISTS virtual_workflow_steps(
      flow_id TEXT NOT NULL REFERENCES virtual_workflow_definitions(flow_id),
      step_order INTEGER NOT NULL CHECK(step_order>0), action_text TEXT NOT NULL,
      expected_text TEXT NOT NULL, api_method TEXT, api_path TEXT,
      database_effect_json TEXT, actor_roles_json TEXT NOT NULL DEFAULT '[]', PRIMARY KEY(flow_id,step_order));
    CREATE TABLE IF NOT EXISTS virtual_workflow_source_links(
      flow_id TEXT NOT NULL REFERENCES virtual_workflow_definitions(flow_id),
      source_table TEXT NOT NULL, source_key TEXT NOT NULL,
      source_key_columns TEXT NOT NULL DEFAULT '["id"]',
      reference_status TEXT NOT NULL DEFAULT 'row',
      PRIMARY KEY(flow_id,source_table,source_key));
    CREATE TABLE IF NOT EXISTS virtual_role_flow_guides(
      outline_id INTEGER PRIMARY KEY REFERENCES workflow_definitions(id),
      title TEXT NOT NULL, role_id INTEGER, app_id INTEGER,
      guide_json TEXT NOT NULL, definition_status TEXT NOT NULL DEFAULT 'virtual_draft');
    CREATE TABLE IF NOT EXISTS virtual_flow_catalog_snapshots(
      name TEXT PRIMARY KEY, summary_json TEXT NOT NULL,
      updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
    CREATE VIEW IF NOT EXISTS virtual_flow_status_summary AS SELECT flow_kind,COUNT(*) total,
      SUM(verification_status='missing') missing,
      SUM(verification_status='implemented-unverified') implemented_unverified,
      SUM(verification_status='verified') verified,
      SUM(verification_status='blocked') blocked FROM virtual_workflow_definitions GROUP BY flow_kind;
    ''')
    step_columns={r[1] for r in db.execute('PRAGMA table_info(virtual_workflow_steps)')}
    if 'actor_roles_json' not in step_columns:db.execute("ALTER TABLE virtual_workflow_steps ADD COLUMN actor_roles_json TEXT NOT NULL DEFAULT '[]'")
    columns={r[1] for r in db.execute('PRAGMA table_info(virtual_workflow_source_links)')}
    if 'source_key_columns' not in columns:db.execute("ALTER TABLE virtual_workflow_source_links ADD COLUMN source_key_columns TEXT NOT NULL DEFAULT '[\"id\"]'")
    if 'reference_status' not in columns:db.execute("ALTER TABLE virtual_workflow_source_links ADD COLUMN reference_status TEXT NOT NULL DEFAULT 'row'")


def normalize_references(db, plan):
    tables={r[0] for r in db.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    aliases={'roles':'role_code','api_endpoints':'endpoint_code','auth_route_registry':'route_code'}
    resolved=[];unresolved=[]
    for ref in plan.get('governance_refs',[]):
        table,key=ref['table'],ref['key']
        if table not in tables:
            unresolved.append(ref);continue
        quoted='\"'+table.replace('\"','\"\"')+'\"'
        pk=[r[1] for r in sorted(db.execute('PRAGMA table_info('+quoted+')'),key=lambda r:r[5]) if r[5]]
        if len(pk)!=1 or not isinstance(key,(str,int)):
            unresolved.append(ref);continue
        column=pk[0];items=[]
        if table=='roles' and isinstance(key,str) and ',' in key:
            candidates=[x.strip() for x in key.split(',')]
            items=[r[0] for value in candidates for r in db.execute('SELECT '+column+' FROM '+quoted+' WHERE role_code=?',(value,))]
            if len(items)!=len(candidates):items=[]
        else:
            items=[r[0] for r in db.execute('SELECT '+column+' FROM '+quoted+' WHERE '+column+'=?',(key,))]
            if not items and table in aliases:
                items=[r[0] for r in db.execute('SELECT '+column+' FROM '+quoted+' WHERE '+aliases[table]+'=?',(key,))]
        if items:
            resolved.extend(dict(table=table,key=value,key_columns=pk,reference_status='row') for value in items)
        elif table in ('theme_profiles','theme_design_tokens'):
            ids=[r[0] for r in db.execute('SELECT '+column+' FROM '+quoted+' ORDER BY '+column)]
            resolved.append(dict(table=table,key='*',key_columns=[],reference_status='table_snapshot',row_ids=ids,note='Table-wide catalogue provenance, not a claim about a particular profile/token grant.'))
        else:unresolved.append(ref)
    plan['declared_governance_refs']=plan.get('governance_refs',[])
    plan['governance_refs']=resolved
    if unresolved:
        plan['unresolved_governance_refs']=unresolved
        plan.setdefault('gaps',[]).append('One or more declared governance references do not resolve to exact registered rows; see unresolved_governance_refs.')
        plan['definition_quality']='draft'


def save(db, plan):
    if not all(plan.get(key) for key in ('id', 'title', 'trigger', 'preconditions', 'outcome', 'steps')):
        raise ValueError('Incomplete virtual flow: ' + str(plan.get('id')))
    if any(not s.get('action') or not s.get('expected') for s in plan['steps']):
        raise ValueError('A virtual step needs action and expected outcome: ' + plan['id'])
    # Plans are requirements for future tests, never evidence that the behavior passed.
    definition = encoded(plan)
    fingerprint = hashlib.sha256(definition.encode()).hexdigest()
    old = db.execute('SELECT definition_sha256 FROM virtual_workflow_definitions WHERE flow_id=?', (plan['id'],)).fetchone()
    if old and old[0] == fingerprint:
        for n,step in enumerate(plan['steps'],1):
            db.execute('UPDATE virtual_workflow_steps SET actor_roles_json=? WHERE flow_id=? AND step_order=?',(encoded(step.get('actor_roles',plan.get('actor_roles',[]))),plan['id'],n))
        return
    gaps = list(plan.get('gaps', [])) + ['Virtual plan only: acceptance review and workflow execution have not been completed.']
    db.execute('''INSERT INTO virtual_workflow_definitions(flow_id,flow_kind,title,actor_roles_json,
       trigger_text,preconditions_json,outcome_text,definition_json,definition_sha256,
       definition_status,blocker_json) VALUES(?,?,?,?,?,?,?,?,?,?,?)
       ON CONFLICT(flow_id) DO UPDATE SET title=excluded.title,flow_kind=excluded.flow_kind,
       actor_roles_json=excluded.actor_roles_json,trigger_text=excluded.trigger_text,
       preconditions_json=excluded.preconditions_json,outcome_text=excluded.outcome_text,
       definition_json=excluded.definition_json,definition_sha256=excluded.definition_sha256,
       definition_status=excluded.definition_status,verification_status='blocked',
       blocker_json=excluded.blocker_json,test_status='not_run',updated_at=CURRENT_TIMESTAMP''',
       (plan['id'],plan['kind'],plan['title'],encoded(plan.get('actor_roles',[])),
        plan['trigger'],encoded(plan['preconditions']),plan['outcome'],definition,
        fingerprint,'source_mapped' if plan.get('definition_quality') == 'source_mapped' else 'virtual_draft',encoded(gaps)))
    db.execute('DELETE FROM virtual_workflow_steps WHERE flow_id=?', (plan['id'],))
    db.executemany('INSERT INTO virtual_workflow_steps(flow_id,step_order,action_text,expected_text,api_method,api_path,database_effect_json,actor_roles_json) VALUES(?,?,?,?,?,?,?,?)',
        [(plan['id'],n,s['action'],s['expected'],s.get('api_method'),s.get('api_path'),
          encoded(s.get('db_effect')) if s.get('db_effect') is not None else None,encoded(s.get('actor_roles',plan.get('actor_roles',[]))))
         for n,s in enumerate(plan['steps'],1)])
    db.execute('DELETE FROM virtual_workflow_source_links WHERE flow_id=?', (plan['id'],))
    db.executemany('INSERT OR IGNORE INTO virtual_workflow_source_links(flow_id,source_table,source_key,source_key_columns,reference_status) VALUES(?,?,?,?,?)',
        [(plan['id'],r['table'],str(r['key']),encoded(r.get('key_columns',['id'])),r.get('reference_status','row')) for r in plan.get('governance_refs',[])])


def draft(flow_id, kind, title, actors, trigger, outcome, refs, steps, gaps, source):
    return dict(id=flow_id,kind=kind,title=title,actor_roles=actors,trigger=trigger,
       preconditions=['Use isolated synthetic prerequisites during later testing.',
          'Confirm current role and tenant authorization from the registered policy; metadata does not grant access.'],
       outcome=outcome,governance_refs=refs,steps=steps,gaps=gaps,
       registered_source=source,definition_quality='draft',
       alternative_paths=['Denied roles and foreign tenants must cause no unauthorized business writes.',
          'Exercise empty, loading, invalid-input, error, offline, retry and reload behavior appropriate to this flow.',
          'Validate source-bound evidence and required review before verified status.'])


def populate(db):
    db.row_factory = sqlite3.Row
    prepare(db)
    roles = {r['id']: r['role_code'] for r in rows(db,'roles')}
    screens = {r['id']: r for r in rows(db,'screens')}
    apis = {r['id']: r for r in rows(db,'api_endpoints')}
    legacy_apis = {r['id']: r for r in rows(db,'api_registry')}
    canonical=lambda path:re.sub(r'\{[^}]+\}|:[A-Za-z_][A-Za-z0-9_]*','{}',path.split('?')[0].rstrip('/'))
    modern_contracts={(a['http_method'],canonical(a['route_path'])) for a in apis.values() if a['route_path']}
    legacy_endpoints = {r['id']: r for r in rows(db,'api_endpoint_registry')}
    requirements = {r['screen_id']: r for r in rows(db,'screen_requirements')}
    blueprints = {r['screen_id']: r for r in rows(db,'screen_implementation_blueprints')}
    permissions = defaultdict(list)
    for p in rows(db,'role_screen_permissions'):
        permissions[p['screen_id']].append({key:p[key] for key in ('role_id','can_view','can_create','can_edit','can_delete','can_export')})
    api_links = defaultdict(list)
    for table in ('screen_api_map','screen_api_links','screen_endpoint_map'):
        for r in rows(db,table):
            api_id = r.get('api_id')
            registry = 'api_endpoints' if table=='screen_api_links' else 'api_registry'
            if table=='screen_endpoint_map':
                endpoint=legacy_endpoints.get(r['endpoint_id'])
                api_id=endpoint['api_id'] if endpoint else None
            target=(apis if registry=='api_endpoints' else legacy_apis).get(api_id)
            api_links[r['screen_id']].append(dict(source_table=table,source_id=r['id'],api_id=api_id,
                registry=registry,resolved=target is not None,legacy_mocked=registry=='api_registry' and target is not None and target['status']=='mocked'))
    actions = rows(db,'button_action_definitions')
    expected_ids = set()

    def write(plan):
        if plan['id'] in expected_ids:
            raise ValueError('Duplicate virtual flow ID: '+plan['id'])
        expected_ids.add(plan['id'])
        save(db,plan)

    for sid, s in screens.items():
        actor = [roles[s['role_id']]] if s['role_id'] in roles else []
        source = dict(screen={key:s[key] for key in ('id','screen_code','screen_name','role_id','app_id','route_path','active','actual_file_path')},
             requirement=requirements.get(sid),blueprint=blueprints.get(sid),
             permission_declarations=permissions[sid],api_candidates=api_links[sid])
        gaps=['This is a registered screen journey, not a distinct end-to-end business process.',
              'Database-backed result assertions and executable business preconditions require reconciliation.',
              'Metadata/screen file existence does not prove current skeleton implementation or runtime permission enforcement.']
        if not s['active']: gaps.append('Screen is registered inactive; do not enable it during catalogue creation.')
        if not s['route_path']: gaps.append('No registered screen route.')
        if not api_links[sid]: gaps.append('No registered API mapping.')
        if any(not a['resolved'] for a in api_links[sid]): gaps.append('One or more screen API references do not resolve in their own registry.')
        if any(a['legacy_mocked'] for a in api_links[sid]): gaps.append('Legacy screen APIs are marked mocked and are not interchangeable with modern endpoint bindings.')
        entry = dict(action='Authenticate as an authorized participant using the real login flow.',expected='Session identity, tenant and permission are confirmed before accessing protected data.') if actor else dict(action='Resolve the registered public or protected entry requirement without inventing an actor.',expected='Only public content may be accessible without authentication; resolve any protected role requirement before testing.')
        steps=[entry,
               dict(action='Open the registered screen route: '+str(s['route_path']),expected='The named screen '+s['screen_name']+' renders inside the shared layout; no missing page or unauthorized data.'),
               dict(action='Review the screen data using its registered source/API candidates.',expected='Data-backed results agree with isolated records; static content agrees with governed resources. Resolve exact fields and assertions from requirements.'),
               dict(action='Reload and revisit the same screen.',expected='Permitted data remains accurate; denied/expired access clears protected content; inspect declared loading/empty/error/offline/retry states.')]
        write(draft('screen.'+str(sid),'screen_journey',s['screen_name']+' — registered screen journey',actor,
             (requirements.get(sid) or {}).get('user_story') or 'Open the registered '+s['screen_name']+' screen.',
             'Authorized participant sees the registered screen and accurate permitted results after reload.',
             [dict(table='screens',key=sid)],steps,gaps,source))

    for b in actions:
        screen = screens.get(b['screen_id'])
        actor = [roles[screen['role_id']]] if screen and screen['role_id'] in roles else []
        bound = legacy_apis.get(b['api_id'])
        gaps=['This is a registered action guide; its distinct business outcome and prerequisites need review.',
              'Registered generic request/success descriptions are not complete acceptance criteria.']
        if not bound:gaps.append('No legacy API binding; endpoint/method metadata do not establish an executable API.')
        elif bound['status']=='mocked':gaps.append('Action API resolves to a mocked legacy api_registry contract, not a modern api_endpoints binding.')
        if b['action_type']=='navigate' and b['method'] not in (None,'GET'):
            gaps.append('Navigation action conflicts with a mutation HTTP method in legacy metadata.')
        if not screen:gaps.append('Parent screen is missing.')
        declared_outcome=b['success_result'] or 'No business success condition registered.'
        source=dict(action=b,parent_route=screen['route_path'] if screen else None,
                    resolved_legacy_api={k:bound[k] for k in ('id','api_code','endpoint_path','method','status')} if bound else None)
        steps=[dict(action='Authenticate and open parent screen '+str(screen['route_path'] if screen else None),expected='Only authorized identity and tenant can access this action.'),
               dict(action='Prepare inputs for '+b['button_label'],expected=b['request_payload_description'] or 'Input contract is missing and must be defined before execution.'),
               dict(action='Invoke registered action '+b['button_key']+' using test ID '+str(b['test_id']),
                    expected=declared_outcome,
                    ),
               dict(action='Check exact result, audit and reload or destination as appropriate.',expected='Match the reviewed business result and deny forbidden effects; legacy declaration: '+declared_outcome)]
        write(draft('action.'+str(b['id']),'action_journey',b['button_label']+' — '+b['action_type'],actor,
             'Participant invokes the registered '+b['action_type']+' action.',declared_outcome,
             [dict(table='button_action_definitions',key=b['id'])],steps,gaps,source))

    for aid,a in apis.items():
        source={key:a[key] for key in ('id','endpoint_code','route_path','http_method','auth_required','permission_key','request_schema','response_schema','implementation_status')}
        steps=[dict(action='Resolve the registered request contract and authorized participant.',expected='Real policy establishes required session, scope, inputs and permitted action; no invented permission.'),
               dict(action='Call the registered API with isolated synthetic data.',expected='Validate the declared response contract and exact DB read/write/audit effect; resolve missing assertions before execution.',api_method=a['http_method'],api_path=a['route_path']),
               dict(action='Read back the affected resource, or compare read-only results with database data.',expected='Returned data is accurate and tenant-scoped; retries, failure rollback and forbidden outcomes match the reviewed API contract.')]
        write(draft('api.'+str(aid),'api_contract',a['endpoint_code']+' — API contract guide',[],
             'Exercise registered '+str(a['http_method'])+' '+str(a['route_path']),
             'Registered API contract and exact permitted database effect agree.',
             [dict(table='api_endpoints',key=aid)],steps,
             ['API contract guide is not a separate UI business workflow.',
              'Concrete participant, request fixtures, database assertions and business-process grouping need review.',
              'Existing implementation flags do not constitute test evidence.'],source))

    for aid,a in legacy_apis.items():
        source={key:a[key] for key in ('id','api_code','api_name','method','endpoint_path','auth_required','role_required','status','request_schema_json','response_schema_json')}
        steps=[dict(action='Resolve the declared actor and synthetic request for this legacy contract.',expected='Establish a current supported permission and implementation; legacy role_required is not proof of a grant.'),
               dict(action='Reconcile the declared legacy '+str(a['method'])+' '+str(a['endpoint_path'])+' with the current implementation.',expected='Record a reviewed current binding or an exact missing-functionality blocker; do not execute mocked endpoints as proof.'),
               dict(action='Define database read/write, audit, reload and negative assertions.',expected='Review concrete success and forbidden outcomes before this draft is eligible for testing.')]
        write(draft('legacy-api.'+str(aid),'api_contract',a['api_name']+' — legacy API guide',
             [a['role_required']] if a['role_required'] else [],'Resolve legacy API contract '+a['api_code'],
             'Legacy contract is mapped to reviewed implementation and measurable business effect.',
             [dict(table='api_registry',key=aid)],steps,
             ['Legacy API status is '+str(a['status'])+'; it is not verified implementation.',
              'api_endpoint_registry is a mirror, not an additional business flow.',
              'No exact method/path identity with current api_endpoints was found in this audit; mapping requires review.'],source))

    generic_rows=rows(db,'workflows')
    for g in generic_rows:
        steps=[dict(action='Resolve participant and start conditions for '+g['workflow_name'],expected='Requirements identify actual authorized roles, screens and inputs.'),
               dict(action='Map the registered process description to concrete actions: '+str(g['description']),expected='Every step has an existing screen/API binding and measurable database result.'),
               dict(action='Define terminal result and failure paths.',expected='The registered description is translated into reviewed acceptance criteria before execution.')]
        write(draft('legacy-process.'+str(g['id']),'legacy_candidate',g['workflow_name'],[],
            g['description'] or 'Registered generic process',g['description'] or 'Business outcome not defined.',
            [dict(table='workflows',key=g['id'])],steps,
            ['Generic process registration lacks concrete actor, step, API and database acceptance bindings.'],g))

    domain_files=sorted(PLAN_DIR.glob('*.json'))
    registered_specs={r['workflow_id']:r for r in rows(db,'business_workflow_specs')}
    imported_spec_ids=set()
    if not domain_files: raise ValueError('Domain virtual definitions are required before completing catalogue')
    for path in domain_files:
        for plan in json.loads(path.read_text()):
            plan={**plan,'kind':'business_process'}
            plan['source_sha256']={}
            if plan['id'] in registered_specs:
                existing=registered_specs[plan['id']]
                plan['existing_business_spec']=dict(workflow_id=existing['workflow_id'],specification_sha256=existing['specification_sha256'],definition=json.loads(existing['definition_json']),note='Original narrow specification retained; this catalogue does not overwrite or verify it.')
                imported_spec_ids.add(plan['id'])
            for name in plan.get('source_paths',[]):
                source=(ROOT/name).resolve()
                if not source.is_relative_to(ROOT.resolve()) or not source.is_file():
                    plan.setdefault('gaps',[]).append('Referenced source unavailable in current checkout: '+name)
                    plan['definition_quality']='draft'
                else:
                    plan['source_sha256'][name]=hashlib.sha256(source.read_bytes()).hexdigest()
            for step in plan['steps']:
                method,path=step.get('api_method'),step.get('api_path')
                if method and path and (method,canonical(path)) not in modern_contracts:
                    plan.setdefault('gaps',[]).append('Step API requires governance reconciliation: '+method+' '+path)
                    plan['definition_quality']='draft'
            unknown_roles=[r for r in plan.get('actor_roles',[]) if r not in set(roles.values())]
            if unknown_roles:
                plan.setdefault('gaps',[]).append('Actor role declarations require reconciliation with roles registry: '+', '.join(unknown_roles))
                plan['definition_quality']='draft'
            normalize_references(db,plan)
            write(plan)
    if set(registered_specs)-imported_spec_ids:
        raise ValueError('Existing process definitions need an explicit catalogue crosswalk: '+str(set(registered_specs)-imported_spec_ids))

    business_by_role=defaultdict(list)
    for row in db.execute("SELECT flow_id,actor_roles_json FROM virtual_workflow_definitions WHERE flow_kind='business_process'"):
        for role in json.loads(row['actor_roles_json']):business_by_role[role].append(row['flow_id'])
    outline_rows=rows(db,'workflow_definitions')
    outline_steps=defaultdict(list)
    for step in rows(db,'workflow_steps'):
        outline_steps[step['workflow_id']].append(step)
    for outline in outline_rows:
        guide=dict(outline=outline,role_code=roles.get(outline['role_id']),business_process_ids=sorted(business_by_role[roles.get(outline['role_id'])]),
           note='Role/app guide only; one role can participate in multiple processes and shared processes are not duplicated per role.',
           registered_steps=[dict(**s,virtual_screen_flow='screen.'+str(s['screen_id']) if s['screen_id'] in screens else None)
                for s in sorted(outline_steps[outline['id']],key=lambda x:x['step_order'])])
        db.execute('''INSERT INTO virtual_role_flow_guides(outline_id,title,role_id,app_id,guide_json)
             VALUES(?,?,?,?,?) ON CONFLICT(outline_id) DO UPDATE SET title=excluded.title,
             role_id=excluded.role_id,app_id=excluded.app_id,guide_json=excluded.guide_json''',
             (outline['id'],outline['workflow_name'],outline['role_id'],outline['app_id'],encoded(guide)))

    actual={r[0] for r in db.execute('SELECT flow_id FROM virtual_workflow_definitions')}
    old=actual-expected_ids
    source_audit={
       'orphan_screen_api_links':[dict(r) for r in db.execute('SELECT l.id,l.screen_id,l.api_id FROM screen_api_links l LEFT JOIN screens s ON s.id=l.screen_id WHERE s.id IS NULL')],
       'orphan_screen_permission_ids':[r[0] for r in db.execute('SELECT p.id FROM role_screen_permissions p LEFT JOIN screens s ON s.id=p.screen_id WHERE s.id IS NULL')],
       'orphan_api_permission_ids':[r[0] for r in db.execute('SELECT p.id FROM api_permissions p LEFT JOIN api_endpoints a ON a.id=p.api_id WHERE a.id IS NULL')],
       'note':'Legacy broad grants and permission declarations are not effective runtime authorization proof.'}
    db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('source-gaps',encoded(source_audit)))
    summary=dict(scope='All records in the named current governance sources plus explicitly source-mapped domain processes; virtual plans only, no workflow execution.',
        source_counts=dict(screens=len(screens),registered_actions=len(actions),api_endpoints=len(apis),legacy_api_registry=len(legacy_apis),generic_processes=len(generic_rows),role_outlines=len(outline_rows),role_outline_steps=sum(map(len,outline_steps.values()))),
        by_kind=[dict(r) for r in db.execute('SELECT * FROM virtual_flow_status_summary ORDER BY flow_kind')],
        total_virtual_flows=len(actual),total_virtual_steps=db.execute('SELECT COUNT(*) FROM virtual_workflow_steps').fetchone()[0],
        role_guides=db.execute('SELECT COUNT(*) FROM virtual_role_flow_guides').fetchone()[0],
        business_definition_quality={r[0]:r[1] for r in db.execute("SELECT definition_status,COUNT(*) FROM virtual_workflow_definitions WHERE flow_kind='business_process' GROUP BY definition_status")},
        workflow_tests_executed=0,verified_by_catalogue_creation=0,existing_business_specs_crosslinked=len(imported_spec_ids),
        inventory_gap_counts={key:len(value) for key,value in source_audit.items() if isinstance(value,list)},
        historical_entries_retained=sorted(old),
        limitation='Screen, action and API guides overlap and must not be summed as distinct business processes. Unknown semantics remain explicit draft gaps. Theoretical unregistered processes are outside this finite catalogue.')
    audit_path=ROOT/'docs/task-progress/virtual-flow-source-audit.json'
    if audit_path.is_file():
        db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('legacy-source-audit',audit_path.read_text()))
    for source,kind,count in [('screens','screen_journey',len(screens)),('button_action_definitions','action_journey',len(actions)),('api_endpoints','api_contract',len(apis)),('workflows','legacy_candidate',len(generic_rows)),('api_registry','api_contract',len(legacy_apis))]:
        current_keys={str(r[0]) for r in db.execute('SELECT id FROM '+source)}
        linked={r[0] for r in db.execute('SELECT DISTINCT source_key FROM virtual_workflow_source_links l JOIN virtual_workflow_definitions d USING(flow_id) WHERE l.source_table=? AND d.flow_kind=?',(source,kind))}
        covered=len(current_keys & linked)
        if covered!=count:raise ValueError('Incomplete coverage: '+source)
    db.execute('INSERT INTO virtual_flow_catalog_snapshots VALUES(?,?,CURRENT_TIMESTAMP) ON CONFLICT(name) DO UPDATE SET summary_json=excluded.summary_json,updated_at=CURRENT_TIMESTAMP',('current',encoded(summary)))
    return summary


if __name__=='__main__':
    with sqlite3.connect(ROOT/'.agents/governance/governance.db') as db:
        db.execute('PRAGMA foreign_keys=ON')
        summary=populate(db)
    (ROOT/'docs/task-progress/virtual-flow-catalog-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))
