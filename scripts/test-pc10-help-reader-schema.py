"""Validate accepted self-contained wire definitions, including UTF-16 limits."""
import json
from pathlib import Path
from jsonschema import Draft202012Validator, ValidationError, validators
root=Path(__file__).resolve().parents[1]
contract=json.loads((root/'tools/governance-production/pc10-help-reader-contract.json').read_text())
cases=json.loads((root/'docs/appearance/pc10-section2-help-proposal.json').read_text())['mechanicalSchemaCases']
def utf16(validator,maximum,value,schema):
    if isinstance(value,str) and len(value.encode('utf-16-le'))//2>maximum:
        yield ValidationError('UTF-16 bound exceeded')
Validator=validators.extend(Draft202012Validator,{'x-utf16MaxCodeUnits':utf16})
for key in ['requestSchema','responseSchema']:Draft202012Validator.check_schema(contract[key])
for case in cases:
    schema={'$ref':'#/$defs/'+case['schema'],'$defs':contract['requestSchema']['$defs']}
    assert Validator(schema).is_valid(case['value'])==case['valid'],case['name']
print(f'PASS {len(cases)} accepted Help schema cases, including UTF-16 limits')
