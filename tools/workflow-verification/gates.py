"""Fail-closed status aggregation; this does not execute or approve workflows."""
import hashlib
from pathlib import Path

GATES = ('registration', 'files', 'architecture', 'behavior', 'security', 'evidence', 'review')
STATUSES = {'passed', 'failed', 'blocked', 'unverified', 'skipped'}


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def evaluate(record, source_root):
    """Evaluate recorded gate evidence against exact current file bytes.

    Passed gates require evidence references and source/specification bindings.
    References are local reproducible artifacts, never assertions of approval.
    Approval authenticity and test execution belong to the evidence producer.
    """
    root = Path(source_root).resolve()

    def current(bindings):
        if not isinstance(bindings, dict) or not bindings:
            return False
        for name, expected in bindings.items():
            path = (root / name).resolve()
            if not path.is_relative_to(root) or not path.is_file():
                return False
            if digest(path) != expected:
                return False
        return True

    results = {}
    for name in GATES:
        gate = record.get('gates', {}).get(name, {})
        status = gate.get('status', 'blocked')
        reason = gate.get('reason', 'Required gate has no recorded result.')
        if status not in STATUSES:
            status, reason = 'blocked', 'Invalid gate status.'
        elif status == 'passed':
            if not all(current(gate.get(key)) for key in ('sources', 'specifications', 'artifacts')):
                status, reason = 'unverified', 'Missing, unsafe or stale source, specification or evidence binding.'
            elif name == 'review' and not gate.get('approval_id'):
                status, reason = 'blocked', 'Required approval reference is missing.'
            else:
                reason = 'Recorded evidence matches current bound files.'
        results[name] = {'status': status, 'reason': reason}
    statuses = {g['status'] for g in results.values()}
    overall = next((s for s in ('failed', 'blocked', 'skipped', 'unverified') if s in statuses), 'passed')
    return {'workflow_id': record.get('workflow_id'), 'status': overall, 'green': overall == 'passed', 'gates': results}
