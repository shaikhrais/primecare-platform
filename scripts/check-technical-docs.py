"""Validate documentation coverage and finite-operation traceability, without writes."""
import importlib.util
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DIRECTORY = ROOT / 'docs/technical'
REQUIRED = ('README.md', 'system-requirements.md', 'architecture-data.md',
            'security-authorization.md', 'api-workflow-contracts.md',
            'runtime-operations.md', 'testing-release.md', 'implementation-plan.md',
            'identity-work-package.md', 'family-decision-register.md',
            'PRIMECARE_TECHNICAL_MANUAL.md', 'operation-register.json',
            'project-inventory.json', 'execution-state.json')


def require(condition, message):
    if not condition:
        raise ValueError(message)


def main():
    for name in REQUIRED:
        path = DIRECTORY / name
        require(path.is_file() and not path.is_symlink(), 'Missing or unsafe technical document: ' + name)
    spec = importlib.util.spec_from_file_location('technical_register', ROOT / 'scripts/build-technical-operation-register.py')
    generator = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(generator)
    for relative, expected in generator.build().items():
        require((ROOT / relative).read_text() == expected, 'Stale generated technical document: ' + relative)
    register = json.loads((DIRECTORY / 'operation-register.json').read_text())
    checklist = json.loads((ROOT / 'docs/api/api-delivery-checklist.json').read_text())
    actual = register['operations']
    expected = checklist['operations']
    require({o['api'] for o in actual} == {o['api'] for o in expected}, 'Missing or extra exact API identities')
    require(len(actual) == len({o['api'] for o in actual}), 'Duplicate API identity')
    require(len(actual) == len({o['requirementId'] for o in actual}), 'Duplicate API requirement ID')
    require(register['uniqueOperations'] == len(actual) == checklist['summary']['uniqueOperations'], 'Invalid operation totals')
    require(register['completionCredits'] == 0 and all(o['completionCredits'] == 0 for o in actual), 'Documentation cannot award API credit')
    unresolved = {o['api'] for o in expected if o['stage'] in ('blocked', 'needs_contract_and_verification')}
    members = {o['api'] for f in register['familyDecisions'] for o in f['operations']}
    require(unresolved == members, 'Family decisions do not cover the unresolved finite queue')
    inventory = json.loads((DIRECTORY / 'project-inventory.json').read_text())
    require(re.fullmatch(r'[0-9a-f]{40}', inventory['sourceCommit']) is not None, 'Inventory is not commit-pinned')
    require(len(inventory['projects']) == len({p['path'] for p in inventory['projects']}), 'Duplicate project path')
    for project in inventory['projects']:
        require(not project.get('error'), 'Project inventory has retrieval errors')
        require(re.fullmatch(r'[0-9a-f]{40}', project['tree']) is not None, 'Project tree is not pinned')
        for manifest in project['manifests']:
            require(manifest['path'].startswith(project['path'] + '/'), 'Manifest outside its project')
            require(re.fullmatch(r'[0-9a-f]{40}', manifest['blob']) is not None, 'Manifest blob is not pinned')
    execution = json.loads((DIRECTORY / 'execution-state.json').read_text())
    require(execution['baseline']['newApiCompletions'] == 0, 'This documentation/evidence package implements no APIs')
    require(execution['baseline']['pending'] == checklist['summary']['stages']['needs_contract_and_verification'], 'Pending baseline drift')
    require(execution['baseline']['blocked'] == checklist['summary']['stages']['blocked'], 'Blocked baseline drift')
    for path in DIRECTORY.glob('*.md'):
        text = path.read_text()
        require(text.startswith('# '), 'Missing document title: ' + path.name)
        require(sum(line.startswith('```') for line in text.splitlines()) % 2 == 0, 'Unbalanced code fences: ' + path.name)
        for match in re.finditer(r'\[[^\]\n]+\]\(([^)\n]+)\)', text):
            target = match.group(1)
            if '://' in target or target.startswith(('#', 'mailto:')):
                continue
            target = target.split('#', 1)[0]
            require(not Path(target).is_absolute(), 'Use repository-relative document links: ' + path.name)
            resolved = (path.parent / target).resolve()
            require(resolved.is_relative_to(ROOT), 'Link escapes repository: ' + path.name)
            require(resolved.exists(), 'Broken local document link: ' + path.name + ' -> ' + target)
    print(json.dumps({'documents': len(REQUIRED), 'uniqueOperations': len(actual),
                      'unresolvedOperations': len(unresolved), 'families': len(register['familyDecisions']),
                      'projects': len(inventory['projects']), 'completionCredits': 0}))


if __name__ == '__main__':
    main()
