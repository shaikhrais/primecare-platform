"""Count each exact method/path once; keep evidence gates distinct."""
import hashlib, json
from collections import Counter, defaultdict
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]

def build(rows, work_package=None):
    grouped = defaultdict(list)
    for row in rows:
        grouped[row['method']+' '+row['route']].append(row)
    operations = []
    for api, declarations in sorted(grouped.items()):
        states = {r['verificationState'] for r in declarations}
        missing = sorted({f for r in declarations for f in r['missingContractFields']})
        stage = ('blocked' if states == {'blocked'} else
                 'unit_evidence_recorded' if states == {'unit_fixtures_recorded'} and not missing else
                 'needs_reconciliation' if len(states) > 1 else 'needs_contract_and_verification')
        first = declarations[0]
        area = first['route'].split('/')[2] if first['route'].startswith('/v1/') else 'other'
        operations.append({'api':api,'method':first['method'],'route':first['route'],
            'declarationIds':sorted(r['id'] for r in declarations),
            'services':sorted({r['service'] for r in declarations}), 'area':area,
            'stage':stage,'missingContractFields':missing,
            'unitEvidenceRecorded':stage=='unit_evidence_recorded',
            'postgresEvidence':'not_mapped_per_operation',
            'productionEvidence':'not_mapped_per_operation',
            'nextAction':('Resolve registered business/authority blocker' if stage=='blocked' else
                'Map operation-specific PostgreSQL evidence and release checks' if stage=='unit_evidence_recorded' else
                'Reconcile method/path with handler and callers; register authority and schemas; test before marking verified')})
    stages = dict(sorted(Counter(o['stage'] for o in operations).items()))
    pending = [o for o in operations if o['stage'] not in ['unit_evidence_recorded','blocked']]
    auth = [o['api'] for o in pending if o['area']=='auth']
    package = work_package or {'name':'Reconcile legacy auth declarations with existing handlers and callers','operations':auth,'retirements':{}}
    if len(package['operations']) != len(set(package['operations'])): raise ValueError('Duplicate work-package operation')
    lookup = {o['api']:o for o in operations}; resolved = []
    for api in package['operations']:
        if lookup.get(api,{}).get('unitEvidenceRecorded'): resolved.append(api)
        elif api not in lookup:
            retirement = package.get('retirements',{}).get(api,{})
            if retirement.get('reason') and retirement.get('evidence'): resolved.append(api)
    areas = []
    for area in sorted({o['area'] for o in operations}):
        members = [o for o in operations if o['area']==area]
        areas.append({'area':area,'total':len(members),
            'unitEvidenceRecorded':sum(o['unitEvidenceRecorded'] for o in members),
            'blocked':sum(o['stage']=='blocked' for o in members),
            'needsWork':sum(o['stage'] not in ['unit_evidence_recorded','blocked'] for o in members)})
    return {'countingRule':'One exact HTTP method + path; field repairs and test totals do not increment completed operations.',
        'summary':{'declarations':len(rows),'uniqueOperations':len(operations),
            'duplicateDeclarationRows':len(rows)-len(operations),'stages':stages,
            'pendingByDeclaredMethod':dict(sorted(Counter(o['method'] for o in pending).items())),
            'postgresEvidenceMapped':0,'productionEvidenceMapped':0},
        'firstWorkPackage':{'name':package['name'],'total':len(package['operations']),
            'resolved':len(resolved),'operations':package['operations'],'resolvedOperations':resolved,
            'reviewed':sum(bool(r.get('finding') and r.get('evidence')) for api,r in package.get('reviews',{}).items() if api in package['operations'])},'areas':areas,'operations':operations}

def main():
    source = ROOT/'docs/api/api-execution-inventory.json'
    package = json.loads((ROOT/'docs/api/api-delivery-work-package.json').read_text())
    data = build(json.loads(source.read_text())['data'],package)
    data['additionalWorkPackages'] = [build(json.loads(source.read_text())['data'],p)['firstWorkPackage'] for p in package.get('additionalWorkPackages',[])]
    data['source'] = {'path':'docs/api/api-execution-inventory.json','sha256':hashlib.sha256(source.read_bytes()).hexdigest()}
    (ROOT/'docs/api/api-delivery-checklist.json').write_text(json.dumps(data,indent=2)+'\n')
    s=data['summary']; states=s['stages']; package=data['firstWorkPackage']
    lines=['# Finite API delivery checklist','',data['countingRule'],'',
        f"Baseline: **{s['uniqueOperations']} unique operations** from {s['declarations']} declarations; {s['duplicateDeclarationRows']} duplicate declaration row.",'',
        '| Evidence stage | Unique operations |','| --- | ---: |']
    lines += [f'| {stage} | {count} |' for stage,count in states.items()]
    lines += ['', 'Unit evidence is a completed test milestone, not proof of complete business workflows or deployment. PostgreSQL CI has passed globally, but this checklist does not invent operation-specific coverage. Production status remains unverified here.','',
        '## Completion rule','',
        'An operation earns one completed API credit only when its exact method/path and callers are reconciled, its handler and registered authority/request/response contracts exist, its unit/negative authorization tests pass, and operation-specific PostgreSQL evidence is linked. Deployment and authenticated production checks are separate release gates. Duplicate/stale declarations must be retired with recorded rationale rather than implemented blindly. A POST declaration is not automatically a business write.','',
        '## First finite work package','',f"**{package.get('reviewed',0)}/{package['total']} reviewed; {package['resolved']}/{package['total']} resolved: {package['name']}.**",'',
        'The work-package denominator is fixed; a missing declaration only resolves through a documented retirement with evidence. Check handler and gateway behavior, caller methods and schema/authority registration for each item. Record one disposition per operation: verify implementation, implement a justified missing operation, or retire/replace a stale declaration. No broad access grants may be inferred from a catalog label.','']
    lines += [('- [x] ' if api in package['resolvedOperations'] else '- [ ] ')+api for api in package['operations']]
    for extra in data['additionalWorkPackages']:
        lines += ['', '## Next finite work package', '', f"**{extra['reviewed']}/{extra['total']} reviewed; {extra['resolved']}/{extra['total']} resolved: {extra['name']}.**", '']
        lines += [('- [x] ' if api in extra['resolvedOperations'] else '- [ ] ')+api for api in extra['operations']]
    lines += ['', '## Work by route area','', '| Area | Total | Unit evidence | Needs work | Blocked |','| --- | ---: | ---: | ---: | ---: |']
    lines += [f"| {a['area']} | {a['total']} | {a['unitEvidenceRecorded']} | {a['needsWork']} | {a['blocked']} |" for a in data['areas']]
    lines += ['', 'Route areas are catalog prefixes, not independently deployed services. The JSON checklist contains every unique operation, source declaration IDs, missing fields and next action. Regenerate through generate-api-execution-inventory.py; never advance this counter for repeated field repairs.','']
    (ROOT/'docs/api/API_DELIVERY_CHECKLIST.md').write_text('\n'.join(lines))
    print(json.dumps(s))

if __name__=='__main__': main()
