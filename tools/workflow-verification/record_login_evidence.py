"""Idempotent scoped login metadata import. Never promotes a workflow to verified.

Run only in the protected GitHub production metadata job after the credential-free
collector. created_at is ingestion time; execution timestamps are immutable source
facts. A flow_id is the existing checkpoint primary key (there is no numeric ID).
"""
import argparse
import datetime as dt
import hashlib
import json
import inspect
import re
from pathlib import Path

from execution import ROOT, encoded, record_attempt, _path
from gates import digest
from production_store import ProductionWorkflowStore

REPOSITORY = 'shaikhrais/primecare-platform'
WORKFLOW = '.github/workflows/verify-login-session-race.yml'
FLOW = 'auth.credential-login'
LOCALES = {'en', 'fr', 'es'}
LIMITATION = ('Scoped isolated Chromium/PostgreSQL login-session replacement probe only. '
              'Not deployed, native/mobile/PWA or full workflow acceptance; live definition '
              'reconciliation and independent review remain pending. Replacement uses a '
              'second API login token injected into sessionStorage, not a second UI login.')


def timestamp(value):
    if not isinstance(value, str):
        raise ValueError('Execution timestamp must be original timezone-aware text.')
    parsed = dt.datetime.fromisoformat(value.replace('Z', '+00:00'))
    if parsed.tzinfo is None:
        raise ValueError('Execution timestamp must carry its original timezone.')
    return parsed


def fingerprint(value):
    return hashlib.sha256(encoded(value).encode()).hexdigest()


def classify(receipt, errors, job):
    """GitHub success may mean expected defect reproduction, never acceptance."""
    if errors or receipt is None:
        return 'blocked', 'No trustworthy browser receipt: ' + '; '.join(errors or ['receipt unavailable'])
    if receipt.get('wholeTaskVerified') is not False or receipt.get('scope') != 'scoped':
        raise ValueError('Only explicitly unverified scoped receipts may be imported.')
    cases = receipt.get('loginLifecycleCases', [])
    baseline = receipt.get('loginLifecycleBaseline') is True
    if receipt.get('passed') is True:
        if (baseline or job.get('conclusion') != 'success' or receipt.get('error') or receipt.get('failures')
                or receipt.get('workflow_id') != FLOW or receipt.get('loginLifecycleOnly') is not True
                or len(cases) != 3 or {c.get('locale') for c in cases} != LOCALES
                or any(c.get('defectReproduced') is True for c in cases)
                or not all(all(c.get(k) is True for k in ('replacementSessionPreserved',
                           'provisionalSessionRevoked', 'noStaleNavigation')) for c in cases)
                or receipt.get('criterion_results', {}).get('ui.login-session-replacement') != 'passed'):
            raise ValueError('Claimed login pass lacks complete matching execution evidence.')
        return 'scoped_pass', None
    if receipt.get('error') or receipt.get('failures'):
        # An error with zero cases remains a failed execution, not defect proof.
        return 'failed', receipt.get('error') or 'The receipt reports a reproduced login-session replacement defect.'
    return 'blocked', 'Browser receipt does not establish completion or a reproducible failure.'


def make_result(item, root=ROOT):
    run, job, matrix = item['run'], item['job'], item['matrix']
    if (run.get('repository', {}).get('full_name') != REPOSITORY
            or run.get('path', '').split('@')[0] != WORKFLOW
            or run.get('head_branch') != 'main' or run.get('status') != 'completed'
            or run.get('event') not in ('push', 'workflow_dispatch')):
        raise ValueError('Only completed first-party main login workflow runs are allowed.')
    if not all(isinstance(value, str) and re.fullmatch(r'[0-9a-f]{40}', value) for value in (run.get('head_sha'), matrix.get('source'))):
        raise ValueError('Original workflow and source commits must be immutable SHAs.')
    run_id, attempt, job_id = run['id'], run['run_attempt'], job['id']
    if any(type(v) is not int or v < 1 for v in (run_id, attempt, job_id)):
        raise ValueError('GitHub run/attempt/job identities must be positive integers.')
    if job.get('run_id') != run_id or job.get('run_attempt') != attempt:
        raise ValueError('GitHub job belongs to another run attempt.')
    run_url = f'https://github.com/{REPOSITORY}/actions/runs/{run_id}'
    if run.get('html_url') != run_url:
        raise ValueError('GitHub run URL identity mismatch.')
    receipt = item.get('receipt')
    errors = item.get('validation_errors', [])
    if receipt is not None and not errors:
        root = Path(root).resolve()
        receipt_path = item.get('receipt_path')
        original_bytes = _path(root, receipt_path).read_bytes()
        if (json.loads(original_bytes) != receipt
                or hashlib.sha256(original_bytes).hexdigest() != item.get('receipt_sha256')
                or not any(e.get('path') == receipt_path and e.get('sha256') == item['receipt_sha256'] for e in item['evidence'])):
            raise ValueError('Original receipt bytes/digest are not independently bound to the packet.')
        originals = receipt.get('source_bindings', {})
        restored = item.get('original_source_files', {})
        if not originals or set(originals) != set(restored):
            raise ValueError('Original source binding reconstruction is incomplete.')
        for name, expected in originals.items():
            local = restored[name]
            if (digest(_path(root, local)) != expected or item['source_bindings'].get(local) != expected):
                raise ValueError('Original source bytes/digest do not match the receipt.')
        if (matrix.get('baseline') == '1' or matrix.get('baseline') == 1) and receipt.get('passed') is True:
            raise ValueError('A baseline matrix job cannot be imported as a pass.')
        if (receipt.get('commit') != matrix['source'] or receipt.get('workflow_run_sha') != run['head_sha']
                or receipt.get('workflow_id') != FLOW
                or not timestamp(job['started_at']) <= timestamp(receipt['started_at']) <= timestamp(receipt['finished_at']) <= timestamp(job['completed_at'])):
            raise ValueError('Original receipt identity or execution time does not match GitHub.')
    status, error = classify(receipt, errors, job)
    trusted = receipt is not None and not errors
    started = receipt['started_at'] if trusted else job['started_at']
    finished = receipt['finished_at'] if trusted else job['completed_at']
    if timestamp(finished) < timestamp(started):
        raise ValueError('Execution finished before it started.')
    artifact = item.get('artifact') or {}
    environment = dict(item.get('environment') or {})
    environment.update({'runner': 'github-actions', 'os': 'ubuntu-24.04',
                        'browser': receipt.get('browser') if trusted else 'not_run_or_unknown',
                        'browser_version': receipt.get('browser_version') if trusted else None,
                        'database': 'postgresql', 'scope': 'isolated-synthetic'})
    original_cases = receipt.get('loginLifecycleCases', []) if trusted else []
    cases = [{**case, 'case_id': 'ui.login-session-replacement:' + str(case.get('locale')),
              'result': 'failed' if case.get('defectReproduced') is True else 'passed'
              if all(case.get(k) is True for k in ('replacementSessionPreserved', 'provisionalSessionRevoked', 'noStaleNavigation')) else 'unknown'}
             for case in original_cases]
    execution = {
        'provider': 'github-actions', 'repository': REPOSITORY, 'workflow_path': WORKFLOW,
        'run_id': run_id, 'run_attempt': attempt, 'job_id': job_id, 'job_name': job['name'],
        'run_url': run_url, 'job_url': job.get('html_url'), 'artifact_id': artifact.get('id'),
        'artifact_url': f'{run_url}/artifacts/{artifact["id"]}' if artifact.get('id') else None,
        'workflow_commit': run['head_sha'], 'source_commit': matrix['source'],
        'environment': environment, 'started_at': started, 'finished_at': finished,
        'cases': cases, 'original_cases': original_cases, 'outcome': status, 'github_conclusion': job.get('conclusion'),
        'receipt_sha256': item.get('receipt_sha256'),
        'source_binding_status': 'historical-bytes-verified' if trusted else 'metadata-only',
        'original_source_bindings': receipt.get('source_bindings', {}) if trusted else {},
        'definition_binding_status': 'bound-at-ingestion; original execution did not bind live definition',
        'original_definition_sha256': receipt.get('definition_sha256') if trusted else None,
        'validation_errors': errors,
    }
    next_action = ('Inspect the failing phase and rerun the pinned login probe; do not infer baseline defect reproduction from an empty case list.'
                   if status in ('failed', 'blocked') else
                   'Reconcile the candidate with current main and the live definition, then execute remaining deployed/full-workflow and independent review gates.')
    result = {
        'status': 'blocked' if status == 'blocked' else 'implemented-unverified',
        'test_status': status, 'scope': 'scoped', 'source_bindings': item['source_bindings'],
        'evidence': item['evidence'], 'blockers': [LIMITATION] + ([error] if error else []),
        'issues': [], 'next_action': next_action,
        'execution': execution,
        'import_identity': f'github-actions:{REPOSITORY}:{run_id}:{attempt}:{job_id}',
    }
    if status == 'failed':
        result['issues'] = [{'criterion_id': 'ui.login-session-replacement',
            'reproduction': f'Rerun original GitHub run {run_id} attempt {attempt}, job {job_id}, pinned source {matrix["source"]}.',
            'expected': 'Complete the isolated login probe, preserving the replacement session and revoking the provisional token.',
            'actual': error, 'affected_sources': list(item['source_bindings'])}]
    # Stable identity detects a conflicting re-import rather than silently changing history.
    result['import_sha256'] = fingerprint({k: result[k] for k in ('execution', 'source_bindings', 'evidence')})
    return result


def save_once(db, result, root=ROOT, flow_id=FLOW):
    existing = []
    for attempt_id, raw in db.execute('SELECT attempt_id,result_json FROM virtual_workflow_attempts WHERE flow_id=?', (flow_id,)):
        previous = json.loads(raw)
        if previous.get('import_identity') == result['import_identity']:
            existing.append((attempt_id, previous))
    if len(existing) > 1:
        raise ValueError('Duplicate existing import identities require investigation.')
    if existing:
        attempt_id, previous = existing[0]
        if previous.get('import_sha256') != result['import_sha256']:
            raise ValueError('Conflicting historical evidence for the same GitHub attempt/job.')
        return {'attempt_id': attempt_id, 'duplicate': True}
    # Constructor-held table locks serialize both deduplication and append.
    checkpoint = db.execute('''SELECT a.result_json FROM virtual_workflow_checkpoints c
        JOIN virtual_workflow_attempts a ON a.attempt_id=c.attempt_id WHERE c.flow_id=?''', (flow_id,)).fetchone()
    update_current = checkpoint is None
    if checkpoint:
        prior_time = json.loads(checkpoint[0]).get('execution', {}).get('started_at')
        if prior_time:
            update_current = timestamp(result['execution']['started_at']) >= timestamp(prior_time)
        # Unknown chronology is not permission to replace the current record.
    output = record_attempt(db, flow_id, result, root, update_current=update_current)
    return {'attempt_id': output['attempt_id'], 'duplicate': False}


def readback(db, attempt_id, flow_id=FLOW):
    row = db.execute('''SELECT a.flow_id,a.result_json,a.created_at,d.verification_status,
        d.test_status,c.flow_id,c.attempt_id,c.next_action FROM virtual_workflow_attempts a
        JOIN virtual_workflow_definitions d ON d.flow_id=a.flow_id
        LEFT JOIN virtual_workflow_checkpoints c ON c.flow_id=a.flow_id WHERE a.attempt_id=?''', (attempt_id,)).fetchone()
    if not row or row[0] != flow_id:
        raise ValueError('Committed attempt readback is missing or belongs to another workflow.')
    result = json.loads(row[1]); execution = result['execution']
    evidence = db.execute('SELECT kind,path,sha256,url FROM virtual_workflow_evidence WHERE attempt_id=? ORDER BY path', (attempt_id,)).fetchall()
    expected = sorted((e['kind'],e['path'],e['sha256'],e.get('url')) for e in result['evidence'])
    if sorted(tuple(e) for e in evidence) != expected:
        raise ValueError('Committed evidence readback differs from the saved attempt.')
    return {'workflow_id': row[0], 'attempt_id': attempt_id, 'checkpoint_id': row[5],
            'checkpoint_id_kind': 'flow_id primary key', 'checkpoint_attempt_id': row[6],
            'next_action': row[7], 'attempt_next_action': result['next_action'],
            'verification_status': row[3], 'current_test_status': row[4],
            'attempt_test_status': result['test_status'], 'ingested_at': row[2],
            'execution': execution, 'evidence': result['evidence'],
            'import_identity': result['import_identity'], 'import_sha256': result['import_sha256']}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--packet', type=Path, required=True)
    args = parser.parse_args()
    if 'update_current' not in inspect.signature(record_attempt).parameters:
        raise RuntimeError('Production integration is not enabled: reviewed historical-append execution patch is required.')
    packet = json.loads(args.packet.read_text())
    readbacks = []
    output = args.packet.parent / 'production-readback.json'
    # Prevalidate every result before the first production transaction.
    absent = [item['matrix']['label'] for item in packet['jobs'] if item.get('job') is None]
    if absent:
        print(json.dumps({'blocked': 'Matrix jobs were never created; no job execution or attempt identity can be invented.', 'jobs': absent}), flush=True)
    results = []
    for item in packet['jobs']:
        if item.get('job') is None:
            continue
        if not item['job'].get('started_at') or not item['job'].get('completed_at'):
            print(json.dumps({'blocked': 'Original job execution timestamps are unavailable; no attempt saved.', 'job_id': item['job']['id']}), flush=True)
            continue
        results.append(make_result(item))
    for result in sorted(results, key=lambda r: timestamp(r['execution']['started_at'])):
        with ProductionWorkflowStore() as db:
            saved = save_once(db, result)
        # Open a separate connection after commit. Uncertain commit failures are
        # surfaced; a later explicit retry is safe because import identity is stable.
        with ProductionWorkflowStore() as db:
            verified = readback(db, saved['attempt_id'])
        if verified['import_sha256'] != result['import_sha256']:
            raise ValueError('Saved import digest failed post-commit readback.')
        verified['duplicate'] = saved['duplicate']
        readbacks.append(verified)
        output.write_text(json.dumps(readbacks, indent=2) + '\n')
        print(json.dumps({k: verified[k] for k in ('workflow_id','attempt_id','checkpoint_id',
              'checkpoint_attempt_id','verification_status','attempt_test_status','duplicate')} |
              {'github_run_url': result['execution']['run_url']}), flush=True)


if __name__ == '__main__':
    main()
