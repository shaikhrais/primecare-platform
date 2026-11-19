from copy import deepcopy
import unittest

from .governance_verify_run import verify_run

SHA = 'a' * 40
RUN = 995


def inputs():
    run = dict(id=RUN, path='.github/workflows/deploy-governance-portal-only.yml',
               event='workflow_dispatch', head_branch='main', head_sha=SHA,
               run_attempt=1, status='completed', conclusion='success')
    def job(name, entries):
        return dict(name=name, run_id=RUN, conclusion='success',
                    steps=[dict(name=k, conclusion=v) for k, v in entries])
    jobs = {'jobs': [
        job('build', [('Build with the existing read-only metadata export', 'success'),
                      ('Seal tested output', 'success')]),
        job('Check artifact and publish only if requested', [
            ('Recheck prior live version and exact artifact', 'success'),
            ('Record successful verification without publishing', 'success'),
            ('Recheck production preconditions and publish only the tested Governance artifact', 'skipped'),
        ]),
    ]}
    return run, jobs


class VerifyRunTest(unittest.TestCase):
    def test_accepts_only_matching_run(self):
        verify_run(*inputs(), SHA, RUN)

    def test_rejects_changed_run_metadata(self):
        for field, value in [
            ('id', RUN + 1), ('head_sha', 'b' * 40), ('head_branch','staging'),
            ('path','other.yml'), ('event','push'), ('run_attempt',2),
            ('status','in_progress'), ('conclusion','failure'),
        ]:
            with self.subTest(field=field), self.assertRaises(ValueError):
                run, jobs = inputs()
                run[field] = value
                verify_run(run, jobs, SHA, RUN)

    def test_rejects_missing_or_changed_checks(self):
        mutations = [
            lambda j: j.pop(),
            lambda j: j[0].update(run_id=RUN+1),
            lambda j: j[0]['steps'].pop(),
            lambda j: j[1]['steps'][0].update(conclusion='failure'),
            lambda j: j[1]['steps'][2].update(conclusion='success'),
        ]
        for mutate in mutations:
            run, jobs = inputs()
            changed = deepcopy(jobs)
            mutate(changed['jobs'])
            with self.assertRaises(ValueError):
                verify_run(run, changed, SHA, RUN)
