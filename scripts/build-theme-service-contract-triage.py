"""Index all retained endpoint candidates against concrete source literals, without approving bindings."""
import argparse
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
OUTPUT = 'docs/appearance/theme-service-contract-triage.json'
def build(root=ROOT):
    source = root / 'docs/appearance/theme-service-candidates.json'
    inventory = json.loads(source.read_text())
    registered_path = 'packages/shared/src/communications/registered-contracts.json'
    registered = json.loads((root / registered_path).read_text())
    historical_path = 'docs/api/api-family-reconciliation.json'
    historical = json.loads((root / historical_path).read_text())
    old_operations = {(op['method'], op['route']): op for op in historical['operations']}
    literal_sources = []
    for folder in ['cloudflare/workers/src', 'packages/shared/src']:
        for path in sorted((root / folder).rglob('*')):
            if path.suffix not in ['.ts', '.mjs']:
                continue
            text = path.read_text(errors='replace')
            literals = [(m.group(1), text.count('\n', 0, m.start()) + 1) for m in re.finditer(r"['\"](/[^'\"\n]{1,300})['\"]", text)]
            literal_sources.append((str(path.relative_to(root)), literals))
    rows = []
    for candidate in inventory['candidates']:
        variants = {candidate['path'], re.sub(r'^/v1(?=/)', '', candidate['path'])}
        matches = [{'path': path, 'line': line, 'literal': literal}
                   for path, literals in literal_sources for literal, line in literals if literal in variants]
        contract_matches = [api for api in registered['apis'] if api['path'] == candidate['path'] and api['method'] == candidate['method']]
        old = old_operations.get((candidate['method'], candidate['path']))
        rows.append({**candidate, 'sourceLiteralMatches': matches,
                     'historicalWorkflowReview': None if old is None else {
                         'evidence': historical_path, 'family': old['familyClassification'],
                         'routingClassification': old['routingClassification'],
                         'missingContractFields': old['missingContractFields'],
                         'businessOperationVerified': old['businessOperationVerified'],
                         'freshProductionProof': False},
                     'registeredContractMatches': [{'catalog': registered_path, 'id': api['id'], 'operation': api['operation'], 'status': api['status'],
                                                    'router': 'cloudflare/workers/src/business-tasks/http.ts',
                                                    'composition': 'cloudflare/workers/src/business-tasks/channels.ts',
                                                    'authorization': 'cloudflare/workers/src/business-tasks/endpoint-policy.ts'} for api in contract_matches],
                     'classification': 'registered_dynamic_router_requires_authority_and_host_acceptance' if contract_matches else 'implementation_candidate_requires_contract_review' if matches else 'no_exact_source_literal_match',
                     'bindingApproved': False, 'runtimeActivated': False,
                     'reviewRequired': ['canonical method/path and router', 'actual handler and business validation',
                                        'actor/role/tenant ownership and grants', 'request/response and storage',
                                        'idempotency/receipt/recovery', 'real host and provider entitlement where applicable']})
    return {'format': 1, 'candidateInventorySha256': hashlib.sha256(source.read_bytes()).hexdigest(),
            'metadataEvidence': inventory.get('evidence'), 'freshProductionReadByThisIndex': False,
            'candidateCount': len(rows), 'candidatesWithLiteralMatches': sum(bool(r['sourceLiteralMatches']) for r in rows),
            'candidatesWithRegisteredDynamicContracts': sum(bool(r['registeredContractMatches']) for r in rows),
            'candidatesWithHistoricalWorkflowGaps': sum(r['historicalWorkflowReview'] is not None for r in rows),
            'approvedBindings': 0, 'newApis': 0, 'newRoleGrants': 0, 'runtimeActivated': False,
            'limits': ['Literal references can be schemas, dispatcher names or shared adapters; they do not establish executable equivalence',
                       'No exact source match is not proof that a dynamic route or another service is absent',
                       'Clinical notes, task notes and personal notes are distinct workflows; do not cross-bind on keywords'],
            'candidates': rows}

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    result = build()
    value = json.dumps(result, indent=2) + '\n'
    target = ROOT / OUTPUT
    if args.check:
        if not target.exists() or target.read_text() != value:
            raise SystemExit('Service contract triage drift')
    else:
        target.write_text(value)
    print(json.dumps({k: result[k] for k in ['candidateCount','candidatesWithLiteralMatches','candidatesWithRegisteredDynamicContracts','approvedBindings']}))

if __name__ == '__main__':
    main()
