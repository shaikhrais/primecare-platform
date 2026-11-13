"""Check production release ordering, source gates and immutable read-only checkout."""
from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parents[1]
p = ROOT / '.github/workflows/release-screen-text.yml'
workflow = yaml.load(p.read_text(), Loader=yaml.BaseLoader)
assert workflow['permissions'] == {'contents': 'read', 'actions': 'read'}
assert workflow['on']['push']['branches'] == ['main']
assert '.github/workflows/release-screen-text.yml' not in workflow['on']['push']['paths'], 'Installing the release workflow must not deploy an older feature'
assert 'packages/flutter_core/lib/src/localization/live_screen_text.dart' in workflow['on']['push']['paths']
assert 'websites/typescript/src/**' in workflow['on']['push']['paths'], 'Every portal source change must use the ordered release'
jobs = workflow['jobs']
assert jobs['release_tests']['if'] == "(github.event_name == 'push' || github.event_name == 'workflow_dispatch') && github.ref == 'refs/heads/main'"
dispatch = workflow['on']['workflow_dispatch']['inputs']
assert set(dispatch) == {'confirm', 'expected_sha'}
assert all(value['required'] == 'true' for value in dispatch.values())
retry = next(step for step in jobs['contract']['steps'] if step.get('name') == 'Validate explicit current-main retry')
assert retry['if'] == "github.event_name == 'workflow_dispatch'"
assert retry['env'] == {'RELEASE_CONFIRM':'${{ inputs.confirm }}','EXPECTED_RELEASE_SHA':'${{ inputs.expected_sha }}'}
assert 'test "$GITHUB_REF" = refs/heads/main' in retry['run']
assert 'test "$RELEASE_CONFIRM" = RELEASE_CURRENT_MAIN' in retry['run']
assert 'test "$EXPECTED_RELEASE_SHA" = "$GITHUB_SHA"' in retry['run']
steps = jobs['release_tests']['steps']
fixture = next(i for i, step in enumerate(steps) if step.get('run') == 'python3 tools/governance-production/prepare-ci-fixture.py')
check = next(i for i, step in enumerate(steps) if step.get('run') == 'python3 scripts/register-live-screen-text.py --check')
assert fixture < check and steps[fixture]['env'] == {'GOVERNANCE_ALLOW_SQLITE_FIXTURES':'1'}
assert 'environment' not in jobs['release_tests'] and 'PRODUCTION_DATABASE_URL' not in jobs['release_tests'].get('env', {}), 'Isolated release fixtures must never receive production credentials'
assert jobs['prepare_portals']['if'] == jobs['release_tests']['if']
assert jobs['prepare_portals']['permissions'] == {'contents':'read'}
assert any(step.get('run') == 'python3 -m tools.deployment.runtime_policy all typescript --require' for step in jobs['prepare_portals']['steps'])
assert 'cancelWorkflowRun' not in p.read_text(), 'Release must preserve valid verification runs'
# Runtime ownership, rather than cancellation, prevents a competing Flutter publish.
flutter = yaml.load((ROOT / '.github/workflows/_deploy-web.yml').read_text(), Loader=yaml.BaseLoader)
flutter_steps = flutter['jobs']['deploy']['steps']
runtime = next(i for i, step in enumerate(flutter_steps) if step.get('id') == 'runtime')
assert 'tools.deployment.runtime_policy' in flutter_steps[runtime]['run'] and 'flutter --github-output' in flutter_steps[runtime]['run']
publish = next(i for i, step in enumerate(flutter_steps) if step.get('name') == 'Deploy website with rate-limit retries')
assert runtime < publish and flutter_steps[publish]['if'] == "steps.runtime.outputs.publish == 'true'"
for job, dependency in [('prepare_portals','contract'),('release_tests','prepare_portals'),('migration','release_tests'),('apis','migration'),('websites','apis'),('smoke','websites')]:
    assert jobs[job]['needs'] == dependency, f'{job} must wait for {dependency}'
assert jobs['migration']['environment'] == 'production'
commands = '\n'.join(step.get('run','') for job in jobs.values() for step in job.get('steps',[]))
assert 'ON_ERROR_STOP=1' in commands
assert commands.count('-f packages/database/migrations/20261013_screen_text.sql') == 1
assert 'git push' not in commands and 'git add' not in commands, 'Release must never publish the governance database'
for job, filename in [('apis','deploy-cloudflare-workers.yml'),('websites','deploy-typescript-websites.yml')]:
    assert jobs[job]['uses'] == './.github/workflows/' + filename
    assert jobs[job]['secrets'] == 'inherit' and jobs[job]['with']['confirm'] == 'DEPLOY'
    assert 'workflow_call:' in (ROOT / '.github/workflows' / filename).read_text()
# The generic deployment must validate every current Worker before the first write,
# then recheck each service immediately before publication.
worker = yaml.load((ROOT / '.github/workflows/deploy-cloudflare-workers.yml').read_text(), Loader=yaml.BaseLoader)
worker_steps = worker['jobs']['deploy']['steps']
auth_proof = next(i for i, step in enumerate(worker_steps) if step.get('name') == 'Verify deployed auth source without modifying auth')
assert worker['permissions'] == {'contents': 'read', 'actions': 'read'}
assert 'node scripts/verify-auth-live-proof-source.mjs' in worker_steps[auth_proof]['run']
preflight = next(i for i, step in enumerate(worker_steps) if step.get('name') == 'Test and verify live Worker preservation before any deployment')
deploy = next(i for i, step in enumerate(worker_steps) if step.get('name') == 'Deploy and capture every API URL')
gateway = next(i for i, step in enumerate(worker_steps) if step.get('name') == 'Deploy service-bound gateway')
assert auth_proof < preflight < deploy < gateway
assert 'services=(client ' in worker_steps[deploy]['run'] and 'services=(auth ' not in worker_steps[deploy]['run']
assert 'node --test scripts/test-generic-worker-deploy.mjs' in worker_steps[preflight]['run']
assert 'node scripts/check-generic-worker-deploy.mjs' in worker_steps[preflight]['run']
assert 'node scripts/check-generic-worker-deploy.mjs --service "${service}"' in worker_steps[deploy]['run']
assert 'node scripts/check-generic-worker-deploy.mjs --service gateway' in worker_steps[gateway]['run']
for job in jobs.values():
    for step in job.get('steps',[]):
        if step.get('uses','').startswith('actions/checkout@'):
            assert 'ref' not in step.get('with',{}), 'All jobs must use the triggering immutable source commit'
print('Release gates validated: tests -> additive migration -> Workers -> Pages -> public smoke; no governance database publishing')
