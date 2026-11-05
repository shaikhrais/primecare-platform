"""Legacy screen verifier, quarantined until runtime evidence is implemented.

Source-file inspection cannot prove navigation, forms, permissions or runtime
readiness. In particular, this tool must never promote governance statuses.
The former SQLite writer is disabled: the pinned PostgreSQL governance store
is the only live authority. ``audit_sources`` is an offline diagnostic only.
"""

import json
import sys
from datetime import datetime, timezone
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parent.parent


def audit_sources(rows, project_root):
    """Return static observations, never runtime verification or DB updates."""
    root = Path(project_root).resolve()
    rows = list(rows)
    failures = []
    source_signature_count = 0
    for row in rows:
        file_path = row['actual_file_path'] or row['expected_file_path']
        reason = None
        if not file_path:
            reason = 'No file path defined'
        else:
            try:
                path = (root / file_path).resolve()
                if not path.is_relative_to(root):
                    reason = 'File path is outside the project root'
                elif not path.is_file():
                    reason = 'Source file is missing or is not a regular file'
                else:
                    content = path.read_text(encoding='utf-8')
                    if any(marker in content for marker in ('class ', 'Widget ', 'build(')):
                        source_signature_count += 1
                    else:
                        reason = 'Missing standard widget or build signature'
            except (OSError, UnicodeError, ValueError, RuntimeError) as exc:
                reason = f'Source inspection failed: {exc}'
        if reason:
            failures.append({'id': row['id'], 'name': row['screen_name'], 'reason': reason})

    return {
        'test_suite': 'verify_screen_runtime',
        'evidence_kind': 'static_source_inspection_only',
        'overall_passed': False,
        'runtime_verified': False,
        'verified_count': 0,
        'total_screens_scanned': len(rows),
        'source_signature_count': source_signature_count,
        'failures': failures,
        'blockers': ['No runtime evidence was collected; source signatures are not runtime proof.'],
    }


def main():
    """Fail closed without connecting to or mutating any governance database."""
    output = audit_sources([], PROJECT_ROOT)
    output['timestamp'] = datetime.now(timezone.utc).isoformat()
    output['blockers'].append(
        'Legacy SQLite verification is disabled. Use the pinned PostgreSQL '
        'governance authority and reviewed runtime evidence before promoting any screen.'
    )
    print('Screen runtime verification blocked: no screens were verified.', file=sys.stderr)
    # Replace stale success output so callers cannot mistake an earlier result
    # for fresh proof. Exit failure even if writing the failure report fails.
    try:
        report = Path(PROJECT_ROOT) / 'screens_verification_result.json'
        report.write_text(json.dumps(output, indent=2) + '\n', encoding='utf-8')
    except OSError as exc:
        print(f'Could not save failure report: {exc}', file=sys.stderr)
    return 1


if __name__ == '__main__':
    sys.exit(main())
