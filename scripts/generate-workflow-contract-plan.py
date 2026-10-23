"""Group exact unresolved operations into contract reviews without changing evidence."""
import argparse, hashlib, json
from collections import Counter
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
RESOLVED_STAGES = {'unit_evidence_recorded', 'retired_with_evidence'}

def safe_path(value):
    if not isinstance(value, str) or not value:
        raise ValueError('Invalid relative evidence path')
    p = Path(value)
    if p.is_absolute() or '..' in p.parts:
        raise ValueError('Invalid relative evidence path')
    return p

def reviewed_amendments(root, hashes):
    """Allow only inspected, reversible differences from historical evidence.

    This does not refresh historical hashes or earn workflow/activation credit.
    Each accepted current file must reconstruct its exact original bytes.
    """
    path=Path(root)/'docs/api/workflow-contract-source-amendments.json'
    if not path.is_file():return {}
    if not path.resolve().is_relative_to(Path(root).resolve()):
        raise ValueError('Source amendment document escapes repository')
    doc=json.loads(path.read_text())
    keys={'version','noActivation','implementationCredits','retirementCredits','reviewedAtCommit','scope','entries'}
    if (not isinstance(doc,dict) or set(doc)!=keys or type(doc['version']) is not int or doc['version']!=1
        or doc['noActivation'] is not True or any(type(doc[k]) is not int or doc[k]!=0 for k in ['implementationCredits','retirementCredits'])
        or not isinstance(doc['scope'],str) or not doc['scope'].strip() or not hex_digest(doc['reviewedAtCommit'],40)
        or not isinstance(doc['entries'],list) or not 1<=len(doc['entries'])<=20):
        raise ValueError('Invalid nonactivating source amendment document')
    result={}
    for entry in doc['entries']:
        if not isinstance(entry,dict) or set(entry)!={'path','baselineCommit','baselineSha256','reviewedSha256','reason','hunks'}:
            raise ValueError('Invalid source amendment entry')
        filename=entry['path'];safe_path(filename)
        if (filename not in hashes or filename in result or entry['baselineSha256']!=hashes[filename]
            or not hex_digest(entry['baselineCommit'],40) or not hex_digest(entry['reviewedSha256'],64)
            or entry['reviewedSha256']==entry['baselineSha256'] or not isinstance(entry['reason'],str)
            or not entry['reason'].strip() or len(entry['reason'])>4000
            or not isinstance(entry['hunks'],list) or not 1<=len(entry['hunks'])<=30):
            raise ValueError('Unreviewed or duplicate source amendment')
        for hunk in entry['hunks']:
            if (not isinstance(hunk,dict) or set(hunk)!={'before','after'}
                or any(not isinstance(hunk[k],str) or len(hunk[k])>250000 for k in ['before','after'])
                or not hunk['after'] or hunk['before']==hunk['after']):
                raise ValueError('Invalid reversible source amendment hunk')
        result[filename]=entry
    return result

def hex_digest(value,length):
    return isinstance(value,str) and len(value)==length and all(c in '0123456789abcdef' for c in value)

def verify_amended_source(content,entry):
    if hashlib.sha256(content).hexdigest()!=entry['reviewedSha256']:
        raise ValueError('Reviewed source amendment changed: '+entry['path'])
    original=content.decode('utf-8')
    for hunk in reversed(entry['hunks']):
        if original.count(hunk['after'])!=1:
            raise ValueError('Ambiguous source amendment hunk: '+entry['path'])
        original=original.replace(hunk['after'],hunk['before'],1)
    if hashlib.sha256(original.encode('utf-8')).hexdigest()!=entry['baselineSha256']:
        raise ValueError('Source amendment exceeds reviewed scope: '+entry['path'])

def build(checklist, manifest, validate_sources=None):
    if manifest.get('version') != 1 or manifest.get('noActivation') is not True:
        raise ValueError('Contract planning must explicitly forbid activation')
    if manifest.get('baselineUniqueOperations') != checklist['summary']['uniqueOperations']:
        raise ValueError('Baseline unique operation count changed')
    operations = checklist['operations']
    lookup = {o['api']:o for o in operations}
    if len(lookup) != len(operations) or len(lookup) != checklist['summary']['uniqueOperations']:
        raise ValueError('Duplicate or inconsistent checklist identities')
    for o in operations:
        if o['api'] != o['method']+' '+o['route'] or len(set(o['declarationIds'])) != len(o['declarationIds']):
            raise ValueError('Checklist method/path or declaration identity changed')
    declaration_ids=[aid for o in operations for aid in o['declarationIds']]
    if len(declaration_ids)!=len(set(declaration_ids)) or any(not isinstance(aid,int) or isinstance(aid,bool) or aid<1 for aid in declaration_ids) or any(not o['declarationIds'] for o in operations):
        raise ValueError('Declaration identity reused or invalid across operations')
    states = dict(sorted(Counter(o['stage'] for o in operations).items()))
    if states != checklist['summary']['stages']:
        raise ValueError('Checklist evidence stages changed')
    pending = {api for api,o in lookup.items() if o['stage'] not in RESOLVED_STAGES}
    hashes = manifest.get('sourceHashes')
    if not isinstance(hashes,dict) or not hashes:
        raise ValueError('Source provenance hashes missing')
    amendments=reviewed_amendments(validate_sources,hashes) if validate_sources is not None else {}
    for filename,digest in hashes.items():
        path = safe_path(filename)
        if not isinstance(digest,str) or len(digest)!=64 or any(c not in '0123456789abcdef' for c in digest):
            raise ValueError('Malformed source hash')
        if validate_sources is not None:
            file = Path(validate_sources)/path
            if not file.resolve().is_relative_to(Path(validate_sources).resolve()):
                raise ValueError('Source evidence escapes repository: '+filename)
            if not file.is_file():raise ValueError('Source evidence changed: '+filename)
            content=file.read_bytes()
            if filename in amendments:verify_amended_source(content,amendments[filename])
            elif hashlib.sha256(content).hexdigest()!=digest:
                raise ValueError('Source evidence changed: '+filename)
    reviews = manifest.get('reviews',[])
    candidates = {api:[] for api in pending}
    seen = set()
    for review in reviews:
        rid = review['id']
        if not isinstance(rid,str) or not rid or rid in seen:
            raise ValueError('Duplicate or invalid review identity')
        seen.add(rid)
        if not isinstance(review.get('priority'),int) or isinstance(review.get('priority'),bool):
            raise ValueError('Review priority must be an integer')
        if review.get('activationEligible') is not False:
            raise ValueError('Review cannot invent activation eligibility')
        if review.get('implementationCredits',0)!=0 or review.get('retirementCredits',0)!=0:
            raise ValueError('Contract review cannot earn implementation or retirement credit')
        if review.get('authorityDisposition')!='requires_defined_contract' or not review.get('familyKey') or not review.get('title'):
            raise ValueError('Review cannot invent authority or eligibility')
        if not isinstance(review.get('policyDecisions'),list) or not isinstance(review.get('evidencePaths'),list):
            raise ValueError('Review policies or evidence missing')
        for filename in review['evidencePaths']:
            safe_path(filename)
            if filename not in hashes:
                raise ValueError('Unhashed review evidence: '+filename)
        review_seen = set()
        for declaration in review['operations']:
            api=declaration['api']
            if api in review_seen: raise ValueError('Duplicate operation within review')
            review_seen.add(api)
            if api not in pending: raise ValueError('Unknown or resolved operation included in contract review: '+api)
            if sorted(declaration['declarationIds'])!=sorted(lookup[api]['declarationIds']):
                raise ValueError('Declaration IDs changed: '+api)
            candidates[api].append(review)
    if any(not choices for choices in candidates.values()):
        raise ValueError('Unresolved operation coverage missing')
    provenance = manifest.get('provenance',[])
    if not isinstance(provenance,list): raise ValueError('Invalid independent provenance')
    for tag in provenance:
        if tag.get('api') not in lookup: raise ValueError('Unknown provenance operation')
        for reference in tag.get('sourceReferences',[]):
            filename=reference.get('path')
            safe_path(filename)
            if filename not in hashes:raise ValueError('Unhashed independent provenance: '+filename)
    assignments=[]; families={}
    for api in sorted(pending):
        primary=min(candidates[api],key=lambda r:(r['priority'],r['id']))
        assignments.append({'api':api,'declarationIds':lookup[api]['declarationIds'], 'stage':lookup[api]['stage'],
          'primaryReviewId':primary['id'],'familyKey':primary['familyKey'],
          'otherReviewIds':sorted(r['id'] for r in candidates[api] if r['id']!=primary['id']),
          'authorityDisposition':'requires_defined_contract','activationEligible':False})
        group=families.setdefault(primary['familyKey'],{'familyKey':primary['familyKey'],'uniqueOperations':0,'reviewIds':set(),'policyDecisions':[]})
        group['uniqueOperations']+=1;group['reviewIds'].add(primary['id'])
        for policy in primary['policyDecisions']:
            if policy not in group['policyDecisions']:group['policyDecisions'].append(policy)
    for group in families.values():group['reviewIds']=sorted(group['reviewIds'])
    return {'version':1,'noActivation':True,'countingRule':'One primary review per exact unresolved method/path; contract planning earns zero API implementation or retirement credit.',
      'summary':checklist['summary'],'operations':operations,'unresolvedUniqueOperations':len(pending),
      'families':[families[k] for k in sorted(families)],'assignments':assignments,
      'reviews':sorted(reviews,key=lambda r:(r['priority'],r['id'])),'provenance':provenance,
      'sourceHashes':hashes,'implementationCredits':0,'retirementCredits':0}

def render(plan):
    lines=['# Workflow contract plan','',plan['countingRule'],'',
      f"Baseline: **{plan['summary']['uniqueOperations']} unique operations**; **{plan['unresolvedUniqueOperations']} unresolved operations** assigned exactly once. Existing evidence stages are preserved.",'',
      'This plan identifies contracts and policy decisions to define. Existing canonical handlers and source labels are evidence for review, not authorization to activate new workflows.','',
      '| Workflow family | Unique unresolved operations | Primary reviews |','| --- | ---: | --- |']
    for f in plan['families']:lines.append(f"| {f['familyKey']} | {f['uniqueOperations']} | {', '.join(f['reviewIds'])} |")
    for f in plan['families']:
        lines += ['', '## '+f['familyKey'], '']
        for policy in f['policyDecisions']:
            lines.append('- '+(policy if isinstance(policy,str) else json.dumps(policy,sort_keys=True)))
        if not f['policyDecisions']:lines.append('Review source evidence and define the missing authority, input, output, and persistence contracts.')
    lines += ['', 'The JSON preserves all baseline operation states, exact declaration identities, primary and overlapping reviews, and independent provenance tags. No endpoints are activated, implemented, or retired by this planning step.','']
    return '\n'.join(lines)

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--check',action='store_true');args=parser.parse_args()
    checklist=json.loads((ROOT/'docs/api/api-delivery-checklist.json').read_text())
    manifest=json.loads((ROOT/'docs/api/workflow-contract-reviews.json').read_text())
    plan=build(checklist,manifest,ROOT)
    outputs={ROOT/'docs/api/workflow-contract-plan.json':json.dumps(plan,indent=2)+'\n', ROOT/'docs/api/WORKFLOW_CONTRACT_PLAN.md':render(plan)}
    for file,content in outputs.items():
        if args.check:
            if not file.is_file() or file.read_text()!=content:raise SystemExit('Stale workflow plan: '+str(file.relative_to(ROOT)))
        else:file.write_text(content)
    print('Validated contract review coverage: '+str(plan['unresolvedUniqueOperations'])+' unique unresolved operations; zero API credits.')
if __name__=='__main__':main()
