#!/usr/bin/env python3
"""Report fixed recovery targets separately from evidence-based feature acceptance."""
import argparse
from datetime import datetime, timezone
import json
from pathlib import Path
from zoneinfo import ZoneInfo


def timestamp(value):
    parsed = datetime.fromisoformat(value.replace('Z', '+00:00'))
    if parsed.tzinfo is None:
        raise ValueError('Schedule timestamps require a timezone')
    return parsed


def report(plan, now):
    if plan['version'] != 1 or now.tzinfo is None:
        raise ValueError('Unsupported plan or missing current timezone')
    local_zone = ZoneInfo(plan['timezone'])
    timestamp(plan['baseline_at'])
    batches = plan['batches']
    if {row['id'] for row in batches} != {f'B{i:02}' for i in range(1, 19)} or len(batches) != 18:
        raise ValueError('Expected exactly B01-B18')
    low = high = 0
    for row in batches:
        minimum, maximum = row['estimate_active_hours']
        if not 0 < minimum <= maximum:
            raise ValueError('Invalid active-work estimate')
        low += minimum
        high += maximum
    acceptance = plan['acceptance']
    if not 0 <= acceptance['fully_accepted'] <= acceptance['total'] == 72:
        raise ValueError('Invalid feature acceptance counts')
    ids, milestones, overdue = set(), [], []
    completed_early = False
    for row in sorted(plan['milestones'], key=lambda item: timestamp(item['target_end'])):
        if row['id'] in ids:
            raise ValueError('Duplicate milestone')
        ids.add(row['id'])
        target = timestamp(row['target_end'])
        if row['status'] not in {'pending', 'in_progress', 'waiting_ci', 'blocked', 'completed'}:
            raise ValueError('Invalid milestone status')
        if row['status'] == 'blocked' and not row.get('blocker'):
            raise ValueError('Blocked milestone requires the actual missing dependency')
        if row.get('forecast_end'):
            timestamp(row['forecast_end'])
        if row['status'] == 'completed':
            if not row.get('completed_at') or not row.get('evidence'):
                raise ValueError('Completion requires a dated actual and evidence')
            actual = timestamp(row['completed_at'])
            if actual > now:
                raise ValueError('A future completion is not evidence')
            timing = 'late' if actual > target else 'early' if actual < target else 'on_time'
            completed_early |= actual < target and now < target
        else:
            if row.get('completed_at'):
                raise ValueError('An unfinished milestone cannot have a completed actual')
            timing = 'overdue' if now > target else 'not_due'
            if timing == 'overdue':
                overdue.append(row['id'])
        milestones.append({'id': row['id'], 'title': row['title'], 'status': row['status'],
                           'timing': timing, 'target_end': target.astimezone(local_zone).isoformat(),
                           'forecast_end': row.get('forecast_end'), 'blocker': row.get('blocker')})
    actionable = [row for row in milestones if row['status'] not in {'completed', 'blocked'}]
    accepted = acceptance['fully_accepted']
    return {'as_of': now.astimezone(local_zone).isoformat(), 'source_commit': plan['source_commit'],
            'overall_delivery_status': 'complete' if accepted == 72 else 'behind',
            'recovery_schedule_status': 'behind' if overdue else 'ahead' if completed_early else 'on_time',
            'fully_accepted': accepted, 'pending_acceptance': 72 - accepted,
            'estimate_active_hours': [low, high], 'estimate_confidence': 'low',
            'calendar_completion_estimate': None, 'excluded_work': plan['exclusions'],
            'overdue': overdue, 'next_action': actionable[0]['id'] if actionable else None,
            'milestones': milestones}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--plan', type=Path, default=Path(__file__).resolve().parents[1] / 'docs/task-progress/recovery-schedule-20261112.json')
    parser.add_argument('--now', help='Timezone-aware ISO time; defaults to current UTC')
    args = parser.parse_args()
    now = timestamp(args.now) if args.now else datetime.now(timezone.utc)
    print(json.dumps(report(json.loads(args.plan.read_text()), now), indent=2))


if __name__ == '__main__':
    main()
