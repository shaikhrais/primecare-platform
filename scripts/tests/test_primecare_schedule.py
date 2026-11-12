import copy
from datetime import datetime, timezone
from importlib.util import module_from_spec, spec_from_file_location
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[2]
SPEC = spec_from_file_location('primecare_schedule', ROOT / 'scripts/report-primecare-schedule.py')
MODULE = module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class ScheduleTests(unittest.TestCase):
    def setUp(self):
        self.plan = json.loads((ROOT / 'docs/task-progress/recovery-schedule-20261112.json').read_text())
        # Each timing scenario starts before verification; recorded actuals are checked separately.
        for row in self.plan['milestones']:
            row.update(status='pending', completed_at=None, evidence=[], forecast_end=None, blocker=None)
        self.plan['milestones'][0]['status'] = 'waiting_ci'
        self.plan['milestones'][2].update(status='blocked', blocker='Missing approved recovery action binding')
        for row in self.plan['batches']:
            row['estimate_active_hours'] = [1, 2]

    def evaluate(self, when):
        return MODULE.report(self.plan, MODULE.timestamp(when))

    def test_budget_and_no_invented_calendar_date(self):
        result = self.evaluate('2026-11-12T07:05:00-05:00')
        self.assertEqual(result['estimate_active_hours'], [18, 36])
        self.assertEqual(result['overall_delivery_status'], 'behind')
        self.assertEqual(result['pending_acceptance'], 72)
        self.assertIsNone(result['calendar_completion_estimate'])
        self.assertEqual(result['recovery_schedule_status'], 'on_time')

    def test_queue_is_not_a_failure_before_target_but_is_late_after_target(self):
        self.assertEqual(self.evaluate('2026-11-12T08:15:00-05:00')['overdue'], [])
        result = self.evaluate('2026-11-12T08:15:01-05:00')
        self.assertEqual(result['overdue'], ['M01'])
        self.assertEqual(result['next_action'], 'M01')

    def test_revised_forecast_does_not_erase_original_miss(self):
        self.plan['milestones'][0]['forecast_end'] = '2026-11-13T08:15:00-05:00'
        self.assertIn('M01', self.evaluate('2026-11-12T09:00:00-05:00')['overdue'])

    def test_early_evidence_advances_checkpoint_but_not_feature_acceptance(self):
        row = self.plan['milestones'][0]
        row.update(status='completed', completed_at='2026-11-12T07:30:00-05:00', evidence=['https://github.com/shaikhrais/primecare-platform/actions/runs/43213534317'])
        result = self.evaluate('2026-11-12T07:35:00-05:00')
        self.assertEqual(result['recovery_schedule_status'], 'ahead')
        self.assertEqual(result['overall_delivery_status'], 'behind')
        self.assertEqual(result['fully_accepted'], 0)

    def test_blocked_work_is_not_completed_and_next_unblocked_item_is_selected(self):
        for row in self.plan['milestones'][:2]:
            row.update(status='completed', completed_at='2026-11-12T09:00:00-05:00', evidence=['recorded source evidence'])
        result = self.evaluate('2026-11-12T12:30:00-05:00')
        self.assertEqual(result['overdue'], ['M03'])
        self.assertEqual(result['next_action'], 'M04')
        self.assertEqual(result['recovery_schedule_status'], 'behind')

    def test_completion_requires_actual_nonfuture_time_and_evidence(self):
        original = copy.deepcopy(self.plan)
        for actual, evidence in [(None, []), ('2026-11-12T07:01:00-05:00', []), ('2026-11-12T09:00:00-05:00', ['future claim'])]:
            self.plan = copy.deepcopy(original)
            self.plan['milestones'][0].update(status='completed', completed_at=actual, evidence=evidence)
            with self.assertRaises(ValueError):
                self.evaluate('2026-11-12T07:05:00-05:00')

    def test_rejects_duplicate_batches_and_naive_timestamps(self):
        self.plan['batches'][1]['id'] = 'B01'
        with self.assertRaises(ValueError):
            self.evaluate('2026-11-12T07:05:00-05:00')
        with self.assertRaises(ValueError):
            MODULE.timestamp('2026-11-12T07:05:00')

    def test_current_recorded_plan_has_valid_dated_evidence(self):
        actual = json.loads((ROOT / 'docs/task-progress/recovery-schedule-20261112.json').read_text())
        result = MODULE.report(actual, datetime.now(timezone.utc))
        self.assertEqual(result['fully_accepted'], actual['acceptance']['fully_accepted'])


if __name__ == '__main__':
    unittest.main()
