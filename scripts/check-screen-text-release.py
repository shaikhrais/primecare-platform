"""Check production release ordering, source gates and immutable read-only checkout."""
from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parents[1]
p = ROOT / '.github/workflows/release-screen-text.yml'
workflow = yaml.load(p.read_text(), Loader=yaml.BaseLoader)
assert workflow['permissions'] == {'contents': 'read'}
assert workflow['on']['push']['branches'] == ['main']
assert '.github/workflows/release-screen-text.yml' not in workflow['on']['push']['paths'], 'Installing the release workflow must not deploy an older feature'
assert 'packages/flutter_core/lib/src/localization/live_screen_text.dart' in workflow['on']['push']['paths']
jobs = workflow['jobs']
assert jobs['release_tests']['if'] == "github.event_name == 'push' && github.ref == 'refs/heads/main'"
for job, dependency in [('release_tests','contract'),('migration','release_tests'),('apis','migration'),('websites','apis'),('smoke','websites')]:
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
for job in jobs.values():
    for step in job.get('steps',[]):
        if step.get('uses','').startswith('actions/checkout@'):
            assert 'ref' not in step.get('with',{}), 'All jobs must use the triggering immutable source commit'
print('Release gates validated: tests -> additive migration -> Workers -> Pages -> public smoke; no governance database publishing')
