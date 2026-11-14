"""Validate four draft contracts without implementing or activating any service."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
from jsonschema import Draft202012Validator, FormatChecker, validators

ROOT = Path(__file__).resolve().parent
DOCUMENT = ROOT / 'pc10-section2-business-proposals.json'
REPORT = ROOT / 'pc10-section2-business-proposals.validation.json'
helper = importlib.util.spec_from_file_location('help_limits', ROOT / 'pc10-section2-validate-help-proposal.py')
limits = importlib.util.module_from_spec(helper)
helper.loader.exec_module(limits)


def main():
    content = DOCUMENT.read_bytes()
    document = json.loads(content)
    assert document['status'] == 'draft-unapproved'
    assert document['noActivation'] is True and document['runtimeImplemented'] is False
    for key in ['implementationCredits', 'productionWrites', 'grantsChanged', 'providerCalls']:
        assert type(document[key]) is int and document[key] == 0
    assert document['examplesAreSynthetic'] is True
    recorded = json.loads((ROOT.parents[1] / 'packages/flutter_core/test/application_modules/fixtures/application_workflow_identities.json').read_text())
    identities = {row['id']: (row['method'], row['path']) for row in recorded['operations']}
    proposals = document['proposals']
    assert [p['module'] for p in proposals] == ['Academy', 'Commerce', 'AI-chat', 'Finance']
    for proposal in proposals:
        assert proposal['noActivation'] is True and proposal['handlerImplemented'] is False
        assert proposal['permissionKey'] is None and proposal['hostBindingApproved'] is False
        assert proposal['status'] == 'draft-unapproved'
        for operation in proposal['operationCandidates']:
            assert identities[operation['id']] == (operation['method'], operation['path'])
            for name in ['proposedRequest', 'proposedResponse']:
                assert operation[name] in document['schema']['$defs']
    assert proposals[2]['operationCandidates'] == [], 'Do not invent a canonical AI-chat operation'
    Validator = validators.extend(Draft202012Validator, {'x-utf16MaxCodeUnits': limits.utf16_limit})
    Draft202012Validator.check_schema(document['schema'])
    for schema in document['schema']['$defs'].values():
        Draft202012Validator.check_schema(schema)
    results = []
    for case in document['mechanicalSchemaCases']:
        schema = {**document['schema'], '$ref': '#/$defs/' + case['schema']}
        valid = not list(Validator(schema, format_checker=FormatChecker()).iter_errors(case['value']))
        assert valid == case['valid'], 'Unexpected schema result: ' + case['name']
        results.append({'name': case['name'], 'passed': True})
    report = {'scope': 'four-draft-contracts-and-synthetic-examples-only',
              'proposalSha256': hashlib.sha256(content).hexdigest(),
              'casesPassed': len(results), 'results': results,
              'declaredOperationIdentitiesChecked': 4, 'canonicalAiChatOperationEstablished': False,
              'proposalApproved': False, 'handlerImplemented': False,
              'liveDatabaseTested': False, 'providerCalled': False, 'implementationCredits': 0}
    output = json.dumps(report, ensure_ascii=False, indent=2) + '\n'
    if '--check' in sys.argv:
        assert REPORT.read_text() == output, 'Draft validation receipt differs; regenerate'
    else:
        REPORT.write_text(output)
    print(str(len(results)) + '/' + str(len(results)) + ' draft schema cases; 4 recorded operation identities; no implementation/activation')


if __name__ == '__main__':
    main()
