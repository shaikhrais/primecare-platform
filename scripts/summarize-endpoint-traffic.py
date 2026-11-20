"""Summarize exported PrimeCare gateway telemetry message lines."""
import argparse
from collections import Counter, defaultdict
from datetime import datetime, timedelta, timezone
import json
from math import ceil
import sys

PREFIX = 'primecare_endpoint_traffic_v1 '


def summarize(lines, interval_seconds):
    groups = defaultdict(list)
    for line in lines:
        if line.startswith(PREFIX):
            row = json.loads(line[len(PREFIX):])
            groups[row['endpoint']].append(row)
    result = []
    for endpoint, rows in sorted(groups.items()):
        count = len(rows)
        latencies = sorted(row['latencyMs'] for row in rows)
        statuses = Counter(str(row['status']) if row['status'] is not None else 'no_response' for row in rows)
        errors = sum(row['status'] is None or row['status'] >= 500 for row in rows)
        result.append({
            'endpoint': endpoint, 'observedRequests': count,
            'observedRequestsPerSecond': round(count / interval_seconds, 4),
            'statusCounts': dict(sorted(statuses.items())), 'errorOrExceptionRate': errors / count,
            'responseHeaderLatencyP95Ms': latencies[ceil(count * 0.95) - 1],
            **{field: {'knownBytes': sum(row[field] for row in rows if row[field] is not None),
                       'unknownRequests': sum(row[field] is None for row in rows)}
               for field in ('declaredRequestBytes', 'declaredResponseBytes')},
        })
    return {'intervalSeconds': interval_seconds, 'observedRequests': sum(map(len, groups.values())),
            'measurement': 'retained gateway observations; declared body lengths only', 'endpoints': result}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--interval-seconds', type=int, required=True)
    parser.add_argument('--window-ended-at', help='UTC end time of the exported log interval (ISO 8601)')
    args = parser.parse_args()
    if args.interval_seconds < 1:
        parser.error('--interval-seconds must be positive')
    report = summarize(sys.stdin, args.interval_seconds)
    if args.window_ended_at:
        try:
            end = datetime.fromisoformat(args.window_ended_at)
            if end.utcoffset() != timedelta(0):
                raise ValueError()
            start = end - timedelta(seconds=args.interval_seconds)
        except (ValueError, OverflowError):
            parser.error('--window-ended-at must be a valid UTC timestamp')
        report.update(windowStartedAt=start.astimezone(timezone.utc).isoformat(),
                      windowEndedAt=end.astimezone(timezone.utc).isoformat())
    print(json.dumps(report, indent=2))
