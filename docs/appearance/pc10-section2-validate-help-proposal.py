"""Validate synthetic draft examples only; never activate an API or grant access."""
import hashlib
import json
from pathlib import Path
import sys
from jsonschema import Draft202012Validator, ValidationError, validators

ROOT = Path(__file__).resolve().parent
SPEC = ROOT / 'pc10-section2-help-proposal.openapi.json'
PROPOSAL = ROOT / 'pc10-section2-help-proposal.json'
REPORT = ROOT / 'pc10-section2-help-proposal.validation.json'


def utf16_limit(validator, maximum, instance, schema):
    if isinstance(instance, str) and len(instance.encode('utf-16-le')) // 2 > maximum:
        yield ValidationError('Text exceeds the declared UTF-16 code-unit limit')


def main():
    spec_bytes = SPEC.read_bytes()
    spec = json.loads(spec_bytes)
    proposal = json.loads(PROPOSAL.read_text())
    assert spec['openapi'] == '3.1.0'
    assert proposal['status'] == 'draft-unapproved'
    assert proposal['noActivation'] is True
    assert proposal['runtimeImplemented'] is False
    assert proposal['businessAuthorityApproved'] is False
    assert proposal['implementationCredits'] == 0
    assert proposal['productionWrites'] == 0
    assert proposal['grantsChanged'] == 0
    assert proposal['providerCalls'] == 0
    review = spec['x-primecare-review']
    assert review['noActivation'] is True and review['approvedHostBinding'] is False
    assert review['approvedPermissionKey'] is None
    Validator = validators.extend(Draft202012Validator,
                                 {'x-utf16MaxCodeUnits': utf16_limit})
    for schema in spec['components']['schemas'].values():
        Draft202012Validator.check_schema(schema)
    results = []
    for case in proposal['mechanicalSchemaCases']:
        schema = {**spec, '$ref': '#/components/schemas/' + case['schema']}
        valid = not list(Validator(schema).iter_errors(case['value']))
        if valid != case['valid']:
            raise AssertionError('Unexpected schema result: ' + case['name'])
        results.append({'name': case['name'], 'passed': True})
    report = {
        'scope': 'draft-schema-examples-only',
        'openapiSha256': hashlib.sha256(spec_bytes).hexdigest(),
        'casesPassed': len(results), 'results': results,
        'proposalApproved': False, 'handlerImplemented': False,
        'liveDatabaseTested': False, 'providerCalled': False,
        'implementationCredits': 0,
    }
    output = json.dumps(report, ensure_ascii=False, indent=2) + '\n'
    if '--check' in sys.argv:
        assert REPORT.read_text() == output, 'Validation receipt differs; regenerate it'
    else:
        REPORT.write_text(output)
    print(f'{len(results)}/{len(results)} synthetic schema cases passed; draft only, no activation')


if __name__ == '__main__':
    main()
