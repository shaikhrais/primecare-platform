"""Compile source-bound workflow structures; never activate or implement APIs.

Explicit contracts use version 1, noActivation true, and a contracts list. Every
slot needs a value and hashed source references. Missing policy is never inferred.
"""
import argparse
import hashlib
import importlib.util
import json
import math
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SLOTS = ('request', 'response', 'validation', 'authentication', 'authorization',
         'permission', 'rateLimits', 'audit', 'errors', 'version', 'workflow',
         'persistence', 'idempotency', 'tests', 'clientBinding', 'examples')
SLOT_KEYS = {
 'validation':('unknownFields','bounds'),
 'authentication':('mechanism','principal'),
 'permission':('governanceKey','scope'),
 'rateLimits':('scope','limit','window','rejection'),
 'audit':('events','actorAttribution','retention','redaction'),
 'errors':('statusCodes','disclosure'),
 'version':('identifier','compatibility'),
 'workflow':('preconditions','transitions','sideEffects'),
 'persistence':('mappings','transaction','invariants'),
 'idempotency':('duplicate','retry','concurrency','replay'),
 'tests':('positive','negative','tenantIsolation','ownership','state'),
 'clientBinding':('callers','method','route','responseMapping'),
 'examples':('request','response')}
QUESTIONS = {
 'request':'What are the exact parameters, body schema, and bodyless semantics?',
 'response':'What status codes and exact response schemas are approved?',
 'validation':'What validation bounds and unknown-field behavior are approved?',
 'authentication':'Which authentication mechanism and principal are required?',
 'authorization':'Which actor, tenant, ownership, delegation, and state rules authorize this operation?',
 'permission':'Which governance permission authorizes this exact operation?',
 'rateLimits':'What scope, limit, window, and rejection behavior apply?',
 'audit':'Which events, actor attribution, retention, and redaction apply?',
 'errors':'Which errors, status codes, and disclosure constraints apply?',
 'version':'What contract version and compatibility rules apply?',
 'workflow':'What preconditions, transitions, and side effects are approved?',
 'persistence':'Which storage mappings, transactions, and invariants apply?',
 'idempotency':'What duplicate, retry, concurrency, and replay rules apply?',
 'tests':'What positive, negative, tenant-isolation, ownership, and state test cases prove the contract?',
 'clientBinding':'Which callers consume this exact method and path and response?',
 'examples':'Which valid request and response examples are source-approved?'}


def load_planner():
    spec = importlib.util.spec_from_file_location('workflow_plan', ROOT/'scripts/generate-workflow-contract-plan.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def archetype(method, route):
    """A routing hint, explicitly not a business requirement or policy."""
    words = set(re.split(r'[/_-]', route.lower()))
    if 'api' in words: return 'legacy_migration_review'
    if words & {'auth', 'oauth', 'session', 'sessions'}: return 'authentication_review'
    if words & {'scan', 'scans', 'scanner'}: return 'scan_review'
    if words & {'analytics', 'report', 'reports', 'dashboard', 'metrics'}: return 'report_review'
    if method == 'GET': return 'read_item_review' if re.search(r'[:{]', route) else 'read_collection_or_singleton_review'
    if method == 'DELETE': return 'delete_review'
    if method in ('PUT', 'PATCH'): return 'update_review'
    if words & {'approve', 'reject', 'cancel', 'complete', 'submit', 'activate', 'deactivate'}: return 'state_transition_review'
    return 'command_or_creation_review'


def schema(value, root=None):
    """Validate a conservative JSON Schema vocabulary without guessing DTO fields."""
    if isinstance(value, bool): return
    if root is None: root=value
    if not isinstance(value, dict) or not value: raise ValueError('Schema must be a nonempty object or boolean')
    allowed={'$ref','$defs','type','required','properties','items','additionalProperties','not','contains','if','then','else','allOf','anyOf','oneOf','prefixItems','minLength','maxLength','minItems','maxItems','minProperties','maxProperties','minimum','maximum','exclusiveMinimum','exclusiveMaximum','multipleOf','enum','const','title','description','default','examples','format','pattern','uniqueItems','readOnly','writeOnly','deprecated'}
    if set(value)-allowed: raise ValueError('Unsupported schema keywords: '+', '.join(sorted(set(value)-allowed)))
    if '$ref' in value:
        if not isinstance(value['$ref'], str) or not value['$ref'].startswith('#/$defs/'):
            raise ValueError('Schema references must use local $defs')
        name=value['$ref'][len('#/$defs/'):].replace('~1','/').replace('~0','~')
        if '/' in value['$ref'][len('#/$defs/'):] or name not in root.get('$defs',{}): raise ValueError('Unresolved local schema reference')
    if 'type' in value:
        types = value['type'] if isinstance(value['type'], list) else [value['type']]
        if not types or any(t not in ('object','array','string','number','integer','boolean','null') for t in types): raise ValueError('Invalid schema type')
    if 'required' in value and (not isinstance(value['required'],list) or any(not isinstance(x,str) for x in value['required']) or len(value['required'])!=len(set(value['required']))): raise ValueError('Invalid required fields')
    for key in ('properties', '$defs'):
        if key in value:
            if not isinstance(value[key],dict): raise ValueError('Invalid schema map')
            for child in value[key].values(): schema(child,root)
    for key in ('items','additionalProperties','not','contains','if','then','else'):
        if key in value: schema(value[key],root)
    for key in ('allOf','anyOf','oneOf','prefixItems'):
        if key in value:
            if not isinstance(value[key],list) or not value[key]: raise ValueError('Invalid schema composition')
            for child in value[key]: schema(child,root)
    for key in ('minLength','maxLength','minItems','maxItems','minProperties','maxProperties'):
        if key in value and (type(value[key]) is not int or value[key]<0): raise ValueError('Invalid schema bound')
    for key in ('minimum','maximum','exclusiveMinimum','exclusiveMaximum','multipleOf'):
        if key in value and (type(value[key]) not in (int,float) or not math.isfinite(value[key]) or (key=='multipleOf' and value[key]<=0)): raise ValueError('Invalid numeric schema bound')
    for key in ('uniqueItems','readOnly','writeOnly','deprecated'):
        if key in value and type(value[key]) is not bool: raise ValueError('Invalid boolean schema keyword')
    for key in ('title','description','format','pattern'):
        if key in value and not isinstance(value[key],str): raise ValueError('Invalid string schema keyword')
    if 'enum' in value and (not isinstance(value['enum'],list) or not value['enum']): raise ValueError('Invalid enum')
    for low,high in (('minLength','maxLength'),('minItems','maxItems'),('minimum','maximum')):
        if low in value and high in value and value[low]>value[high]: raise ValueError('Inverted schema bounds')
    if not any(k in value for k in ('type','$ref','allOf','anyOf','oneOf','enum','const')): raise ValueError('Schema lacks an explicit shape')


def meaningful(value):
    if value is None or value == '' or value == [] or value == {}: return False
    if isinstance(value,dict): return all(v == [] or meaningful(v) for v in value.values())
    if isinstance(value,list): return all(meaningful(v) for v in value)
    return True


def validate_contract(contract, operation, source_hashes):
    if not isinstance(contract,dict): raise ValueError('Explicit contract must be an object')
    if not isinstance(contract.get('declarationIds'),list) or any(type(i) is not int for i in contract['declarationIds']): raise ValueError('Invalid explicit declaration IDs')
    if contract.get('api') != operation['api'] or contract.get('declarationIds') != operation['declarationIds']: raise ValueError('Explicit contract identity changed')
    if contract.get('noActivation') is not True or contract.get('activationEligible') is not False: raise ValueError('Structure compiler cannot activate APIs')
    if contract.get('implementationCredits',0)!=0 or contract.get('retirementCredits',0)!=0: raise ValueError('Structures cannot earn API credits')
    for flag in ('approved','implemented','productionReady','deployed'):
        if contract.get(flag) is True: raise ValueError('Structure compiler cannot establish '+flag)
    slots = contract.get('slots')
    if not isinstance(slots,dict) or set(slots)!=set(SLOTS): raise ValueError('Explicit contract requires every defined slot')
    for name, slot in slots.items():
        if not isinstance(slot,dict) or not meaningful(slot.get('value')): raise ValueError('Missing explicit slot: '+name)
        refs = slot.get('sourceReferences')
        if not isinstance(refs,list) or not refs: raise ValueError('Missing source authority: '+name)
        for ref in refs:
            if not isinstance(ref,dict) or ref.get('path') not in source_hashes or ref.get('sha256')!=source_hashes[ref['path']]: raise ValueError('Unknown or mismatched source authority: '+name)
            if not meaningful(ref.get('locator')): raise ValueError('Source authority requires exact locator: '+name)
    for name, keys in SLOT_KEYS.items():
        value=slots[name]['value']
        if not isinstance(value,dict) or not all(meaningful(value.get(key)) for key in keys): raise ValueError('Incomplete '+name+' structure; requires '+', '.join(keys))
    if slots['clientBinding']['value']['method'] != operation['api'].split(' ',1)[0] or slots['clientBinding']['value']['route'] != operation['api'].split(' ',1)[1]: raise ValueError('Client method/path binding changed')
    limits=slots['rateLimits']['value']
    if type(limits['limit']) is not int or limits['limit']<1: raise ValueError('Rate limit must be a positive integer')
    request=slots['request']['value'];response=slots['response']['value']
    if not isinstance(request,dict) or set(request)!= {'parameters','body'}: raise ValueError('Request must define parameters and body')
    if not isinstance(request['parameters'],list): raise ValueError('Parameters must be a list')
    seen_parameters=set()
    for parameter in request['parameters']:
        if not isinstance(parameter,dict) or parameter.get('in') not in ('path','query','header','cookie') or not isinstance(parameter.get('name'),str) or type(parameter.get('required')) is not bool: raise ValueError('Invalid request parameter')
        identity=(parameter['in'],parameter['name'])
        if identity in seen_parameters or (parameter['in']=='path' and parameter['required'] is not True): raise ValueError('Duplicate or optional path parameter')
        seen_parameters.add(identity)
        schema(parameter.get('schema'))
    body=request['body']
    if body != {'mode':'none'}:
        if not isinstance(body,dict) or body.get('mode')!='json' or type(body.get('required')) is not bool: raise ValueError('Body must explicitly be none or JSON')
        schema(body.get('schema'))
    if not isinstance(response,dict) or not response: raise ValueError('Response status map required')
    for status, item in response.items():
        if not re.fullmatch(r'[1-5][0-9]{2}',str(status)) or not isinstance(item,dict) or not item.get('description'): raise ValueError('Invalid response status')
        if item.get('bodyless') is not True: schema(item.get('schema'))
    authority=slots['authorization']['value']
    if not isinstance(authority,dict) or not all(meaningful(authority.get(k)) for k in ('actor','tenant','ownership','delegation','state')): raise ValueError('Authorization must define actor, tenant, ownership, delegation, and state')
    return contract


def build(checklist, manifest, contracts=None, validate_sources=None):
    plan=load_planner().build(checklist,manifest,validate_sources)
    supplied={}
    if contracts is not None:
        if not isinstance(contracts,dict): raise ValueError('Explicit contract input must be an object')
        if set(contracts)-{'version','noActivation','contracts'} or contracts.get('version')!=1 or contracts.get('noActivation') is not True or not isinstance(contracts.get('contracts'),list): raise ValueError('Invalid explicit contract input')
        for contract in contracts['contracts']:
            if not isinstance(contract,dict): raise ValueError('Explicit contract must be an object')
            api=contract.get('api')
            if not isinstance(api,str) or api in supplied: raise ValueError('Duplicate explicit contract')
            supplied[api]=contract
    reviews={r['id']:r for r in plan['reviews']}; items=[]; decisions=[]; paths={}; review_evidence={}; operation_references={}
    allowed={a['api'] for a in plan['assignments']}
    if set(supplied)-allowed: raise ValueError('Explicit contract targets unknown or resolved operation')
    for assignment in plan['assignments']:
        api=assignment['api']; method,route=api.split(' ',1)
        if method not in ('GET','POST','PUT','PATCH','DELETE','HEAD','OPTIONS','TRACE') or not route.startswith('/') or '?' in route: raise ValueError('Invalid OpenAPI method/path identity')
        review=reviews[assignment['primaryReviewId']]
        refs=[{'path':p,'sha256':plan['sourceHashes'][p]} for p in review['evidencePaths']]
        review_evidence[review['id']]=refs
        operation_references[api]={'declarationIds':assignment['declarationIds'],'familyKey':assignment['familyKey'],'reviewId':review['id']}
        item={**assignment,'method':method,'route':route,'noActivation':True,'implementationCredits':0,'retirementCredits':0,
          'archetypeHint':archetype(method,route),'archetypeAuthority':'route inference only; never authorization or business requirements',
          'structureStatus':'draft_missing_decisions','slots':{k:{'value':None,'sourceReferences':[]} for k in SLOTS},
          'reviewSourceReferenceId':review['id'],'policyQuestionFamilyKey':assignment['familyKey']}
        if api in supplied:
            explicit=validate_contract(supplied[api],assignment,plan['sourceHashes'])
            item['slots']=explicit['slots'];item['structureStatus']='explicit_structure_compiled_unimplemented'
        items.append(item)
        for slot in SLOTS:
            if item['slots'][slot]['value'] is None: decisions.append({'api':api,'slot':slot})
        operation={'operationId':'declaration_'+str(min(assignment['declarationIds'])),
          'summary':'NONDEPLOYABLE workflow contract review','x-primecare-api':api,'x-primecare-declaration-ids':assignment['declarationIds'],
          'x-primecare-no-activation':True,'x-primecare-structure-status':item['structureStatus'],
          'x-primecare-required-slots':list(SLOTS),'responses':{'default':{'description':'Contract undefined; this draft specifies no runtime response.'}}}
        if item['structureStatus']=='explicit_structure_compiled_unimplemented':
            request=item['slots']['request']['value'];operation['parameters']=request['parameters']
            if request['body']['mode']=='json': operation['requestBody']={'required':request['body']['required'],'content':{'application/json':{'schema':request['body']['schema']}}}
            operation['responses']={str(code):({'description':r['description']} if r.get('bodyless') else {'description':r['description'],'content':{'application/json':{'schema':r['schema']}}}) for code,r in item['slots']['response']['value'].items()}
            operation['x-primecare-explicit-slots']=item['slots']
        # Keep original governance path unchanged, including colon parameters.
        operation['x-primecare-original-route']=route
        openapi_route=re.sub(r':([A-Za-z_][A-Za-z0-9_]*)',r'{\1}',route)
        path_item=paths.setdefault(openapi_route,{})
        if method.lower() in path_item: raise ValueError('OpenAPI path normalization collision')
        existing={p.get('name') for p in operation.get('parameters',[]) if p.get('in')=='path'}
        placeholders=re.findall(r'\{([^{}]+)\}',openapi_route)
        if supplied.get(api) and set(placeholders)!=existing: raise ValueError('Explicit path parameters do not match route')
        if not supplied.get(api) and placeholders:
            operation['parameters']=[{'name':p,'in':'path','required':True,'schema':True,'description':'Unspecified schema; syntax placeholder only.'} for p in placeholders]
        path_item[method.lower()]=operation
    completed=sum(i['structureStatus']=='explicit_structure_compiled_unimplemented' for i in items)
    guard={'version':1,'noActivation':True,'implementationCredits':0,'retirementCredits':0,
      'inputHashes':{'checklist':hashlib.sha256(json.dumps(checklist,sort_keys=True,separators=(',',':')).encode()).hexdigest(),
      'reviews':hashlib.sha256(json.dumps(manifest,sort_keys=True,separators=(',',':')).encode()).hexdigest(),
      'explicitContracts':hashlib.sha256(json.dumps(contracts,sort_keys=True,separators=(',',':')).encode()).hexdigest() if contracts is not None else None}}
    summary={**guard,'baselineUniqueOperations':checklist['summary']['uniqueOperations'],'baselineStages':checklist['summary']['stages'],
      'unresolvedUniqueOperations':len(items),'families':len(plan['families']),'draftStructures':len(items)-completed,'explicitStructuresCompiled':completed,
      'decisionSlotsRemaining':len(decisions),'runtimeHandlersGenerated':0,'databaseWrites':0,
      'meaning':'Structure compilation never establishes governance approval, implementation, authorization enforcement, or deployment readiness.'}
    return {'bundle.json':{**guard,'contracts':items,'families':plan['families'],'reviewEvidence':review_evidence,'sourceHashes':plan['sourceHashes']},
      'openapi-drafts.json':{'openapi':'3.1.0','info':{'title':'PrimeCare NONDEPLOYABLE contract drafts','version':'0.0.0-draft'},'paths':paths,'x-primecare-no-activation':True,'x-primecare-runtime-handlers-generated':0},
      'decision-index.json':{**guard,'decisions':decisions,'questions':QUESTIONS,'operationReferences':operation_references,'familyPolicyDecisions':plan['families']},'execution-summary.json':summary}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check',action='store_true');parser.add_argument('--contracts',type=Path)
    parser.add_argument('--output-dir',default='docs/api/contract-factory')
    parser.add_argument('--verify-sources',action='store_true',help='Source verification is always enabled for CLI execution')
    args=parser.parse_args()
    output=Path(args.output_dir)
    if output.is_absolute() or '..' in output.parts or output==Path('.'): parser.error('Output directory must be a safe repository-relative directory')
    output=(ROOT/output).resolve()
    if not output.is_relative_to(ROOT.resolve()): parser.error('Output directory escapes repository')
    inputs=[ROOT/'docs/api/api-delivery-checklist.json',ROOT/'docs/api/workflow-contract-reviews.json']
    if args.contracts: inputs.append(args.contracts.resolve())
    if any(p.resolve().is_relative_to(output) for p in inputs): parser.error('Output directory must not contain input files')
    explicit=json.loads(args.contracts.read_text()) if args.contracts else None
    artifacts=build(json.loads(inputs[0].read_text()),json.loads(inputs[1].read_text()),explicit,ROOT)
    for name in artifacts:
        path=output/name
        if path.is_symlink() or (path.exists() and not path.is_file()): raise ValueError('Unsafe output target: '+str(path))
    for name,data in artifacts.items():
        path=output/name
        text=(json.dumps(data,indent=2,sort_keys=True) if name=='execution-summary.json' else json.dumps(data,sort_keys=True,separators=(',',':')))+'\n'
        if args.check:
            if not path.is_file() or path.read_text()!=text: raise SystemExit('Stale contract artifact: '+str(path.relative_to(ROOT)))
        else:
            output.mkdir(parents=True,exist_ok=True);path.write_text(text)
    print(json.dumps(artifacts['execution-summary.json'],sort_keys=True))

if __name__=='__main__': main()
