#!/usr/bin/env python3
"""Read-only GitHub evidence collector. Never executes historical repository code.

Requires PyYAML and GH_TOKEN (Actions read, Contents read). The output packet is
an input to the separately authorized metadata recorder, not a verification claim.
"""
import argparse
import datetime as dt
import hashlib
import io
import json
import os
from pathlib import Path, PurePosixPath
import re
import stat
import subprocess
import sys
import tempfile
import urllib.error
import urllib.parse
import urllib.request
import zipfile

import yaml

REPO = 'shaikhrais/primecare-platform'
API = 'https://api.github.com'
WORKFLOW = '.github/workflows/verify-login-session-race.yml'
SCRIPT = 'scripts/test-auth-password-workflow.mjs'
PATCH = 'tools/workflow-verification/patches/login-session-race.patch'
MAX_BYTES = 300 * 1024 * 1024
MAX_FILES = 10000
MAX_SOURCES = 5000
SHA = re.compile(r'[0-9a-f]{40}')
DIGEST = re.compile(r'[0-9a-f]{64}')


class EvidenceError(Exception):
    pass


def require(condition, message):
    if not condition:
        raise EvidenceError(message)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def safe_path(value):
    require(isinstance(value, str) and value and '\\' not in value and '\x00' not in value,
            'Unsafe evidence path')
    p = PurePosixPath(value)
    require(not p.is_absolute() and all(x not in ('', '.', '..') for x in value.split('/')),
            'Unsafe evidence path')
    require(not re.match(r'^[A-Za-z]:', value), 'Unsafe evidence path')
    return p


def timestamp(value):
    require(isinstance(value, str), 'Missing execution timestamp')
    try:
        result = dt.datetime.fromisoformat(value.replace('Z', '+00:00'))
    except ValueError as exc:
        raise EvidenceError('Invalid execution timestamp') from exc
    require(result.tzinfo is not None, 'Execution timestamp lacks timezone')
    return result


class SafeRedirect(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        parsed = urllib.parse.urlsplit(newurl)
        require(parsed.scheme == 'https' and not parsed.username and not parsed.password,
                'Unsafe artifact redirect')
        redirected = super().redirect_request(req, fp, code, msg, headers, newurl)
        if redirected is not None and (parsed.hostname != 'api.github.com' or parsed.port not in (None, 443)):
            redirected.remove_header('Authorization')
        return redirected


class GitHub:
    def __init__(self, token):
        self.token = token
        self.opener = urllib.request.build_opener(SafeRedirect())

    def read(self, path, limit=MAX_BYTES):
        require(path.startswith('/repos/' + REPO + '/'), 'Untrusted GitHub API path')
        request = urllib.request.Request(API + path, headers={
            'Authorization': 'Bearer ' + self.token,
            'Accept': 'application/vnd.github+json',
            'X-GitHub-Api-Version': '2022-11-28',
            'User-Agent': 'primecare-login-evidence-collector',
        })
        try:
            with self.opener.open(request, timeout=90) as response:
                data = response.read(limit + 1)
        except urllib.error.HTTPError as exc:
            raise EvidenceError('GitHub API HTTP ' + str(exc.code)) from None
        except urllib.error.URLError:
            raise EvidenceError('GitHub API connection failed') from None
        require(len(data) <= limit, 'Evidence download exceeds size limit')
        return data

    def json(self, path):
        try:
            return json.loads(self.read(path, 20 * 1024 * 1024))
        except (ValueError, UnicodeError):
            raise EvidenceError('Invalid GitHub API JSON') from None

    def pages(self, path, key):
        output = []
        for page in range(1, 1001):
            data = self.json(path + ('&' if '?' in path else '?') + f'per_page=100&page={page}')
            rows = data.get(key)
            require(isinstance(rows, list), 'Invalid paginated GitHub response')
            output.extend(rows)
            if len(rows) < 100:
                return output
        raise EvidenceError('GitHub pagination limit reached')


def git_file(root, commit, path):
    require(bool(SHA.fullmatch(commit)), 'Invalid source commit')
    safe_path(path)
    p = subprocess.run(['git', 'show', f'{commit}:{path}'], cwd=root,
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False)
    require(p.returncode == 0, 'Pinned source file unavailable locally')
    require(len(p.stdout) <= MAX_BYTES, 'Source file exceeds size limit')
    return p.stdout


def patched_script(root, head):
    original = git_file(root, head, SCRIPT)
    patch = git_file(root, head, PATCH)
    try:
        text = patch.decode('utf-8')
    except UnicodeError:
        raise EvidenceError('Invalid runner patch encoding') from None
    headers = [line for line in text.splitlines() if line.startswith('diff --git ')]
    require(headers == [f'diff --git a/{SCRIPT} b/{SCRIPT}'], 'Runner patch changes unexpected files')
    require([x for x in text.splitlines() if x.startswith('--- ')] == ['--- a/' + SCRIPT]
            and [x for x in text.splitlines() if x.startswith('+++ ')] == ['+++ b/' + SCRIPT],
            'Runner patch has unexpected paths')
    require(not any(x.startswith(('rename ', 'copy ', 'new file ', 'deleted file ', 'old mode ', 'new mode ', 'GIT binary'))
                    for x in text.splitlines()), 'Runner patch changes file metadata')
    with tempfile.TemporaryDirectory(prefix='login-evidence-', dir='/tmp') as tmp:
        destination = Path(tmp) / SCRIPT
        destination.parent.mkdir(parents=True)
        destination.write_bytes(original)
        # git apply is data transformation only, never execution of historical code.
        for flags in (['--check'], []):
            p = subprocess.run(['git', 'apply', *flags, '-'], input=patch, cwd=tmp,
                               stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False,
                               env={**os.environ, 'GIT_CONFIG_NOSYSTEM': '1', 'GIT_CONFIG_GLOBAL': '/dev/null'})
            require(p.returncode == 0, 'Original runner patch cannot be applied')
        return destination.read_bytes()


def extract_zip(data, target):
    try:
        archive = zipfile.ZipFile(io.BytesIO(data))
        seen = set()
        total = 0
        with archive:
            require(len(archive.infolist()) <= MAX_FILES, 'Artifact contains too many files')
            for item in archive.infolist():
                name = item.filename[:-1] if item.is_dir() else item.filename
                path = safe_path(name)
                require(name not in seen, 'Duplicate artifact ZIP path')
                seen.add(name)
                mode = item.external_attr >> 16
                require(not stat.S_ISLNK(mode), 'Artifact ZIP symlink forbidden')
                require(stat.S_IFMT(mode) in (0, stat.S_IFREG, stat.S_IFDIR), 'Special artifact ZIP entry forbidden')
                require(not item.flag_bits & 1, 'Encrypted artifact ZIP forbidden')
                total += item.file_size
                require(total <= MAX_BYTES, 'Expanded artifact exceeds size limit')
                destination = target.joinpath(*path.parts)
                if item.is_dir():
                    destination.mkdir(parents=True, exist_ok=True)
                else:
                    destination.parent.mkdir(parents=True, exist_ok=True)
                    with archive.open(item) as source:
                        content = source.read(item.file_size + 1)
                    require(len(content) == item.file_size, 'ZIP size mismatch')
                    destination.write_bytes(content)
    except (zipfile.BadZipFile, RuntimeError, OSError):
        raise EvidenceError('Malformed artifact ZIP') from None


def matrix_entries(workflow):
    try:
        parsed = yaml.safe_load(workflow)
        job = parsed['jobs']['login-race']
        entries = job['strategy']['matrix']['include']
        require(isinstance(entries, list) and entries, 'Original workflow matrix missing')
        labels = set()
        for entry in entries:
            require(isinstance(entry, dict), 'Invalid workflow matrix')
            label = entry.get('label')
            require(isinstance(label, str) and re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9_-]{0,100}', label), 'Unsafe matrix label')
            require(label not in labels, 'Duplicate matrix label')
            labels.add(label)
            require(isinstance(entry.get('source'), str) and SHA.fullmatch(entry['source']), 'Matrix source is not immutable')
            require(str(entry.get('baseline')) in ('0', '1'), 'Invalid matrix baseline')
        return entries, job
    except (KeyError, TypeError, yaml.YAMLError):
        raise EvidenceError('Cannot parse original workflow matrix') from None


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run-id', type=int, required=True)
    parser.add_argument('--run-attempt', type=int, default=0)
    parser.add_argument('--output-root', default='test-results/login-tracking')
    args = parser.parse_args()
    require(args.run_id > 0 and args.run_attempt >= 0, 'Invalid run identifier')
    root = Path(__file__).resolve().parents[2]
    output_root = (root / args.output_root).resolve()
    require(output_root.is_relative_to(root), 'Output must remain inside checkout')
    token = os.environ.get('GH_TOKEN')
    require(bool(token), 'GH_TOKEN is required')
    github = GitHub(token)
    prefix = '/repos/' + REPO
    repository = github.json(prefix + '/')
    require(repository.get('full_name') == REPO and isinstance(repository.get('id'), int), 'Repository identity conflict')
    run_path = prefix + f'/actions/runs/{args.run_id}'
    latest = github.json(run_path)
    attempt = args.run_attempt or latest.get('run_attempt')
    require(isinstance(attempt, int) and 0 < attempt <= latest.get('run_attempt', 0), 'Invalid run attempt')
    run = github.json(run_path + f'/attempts/{attempt}')
    for candidate in (latest, run):
        require(candidate.get('id') == args.run_id and candidate.get('path') == WORKFLOW
                and candidate.get('head_branch') == 'main'
                and candidate.get('event') in ('push', 'workflow_dispatch'), 'Workflow run identity conflict')
        for key in ('repository', 'head_repository'):
            identity = candidate.get(key) or {}
            require(identity.get('id') == repository['id'] and identity.get('full_name') == REPO,
                    'Run repository identity conflict')
        require(isinstance(candidate.get('head_sha'), str) and SHA.fullmatch(candidate['head_sha']), 'Invalid workflow commit')
    require(run.get('run_attempt') == attempt and run.get('status') == 'completed', 'Requested run attempt is not complete')
    require(run['head_sha'] == latest['head_sha'], 'Run attempt commit conflict')
    run_url = f'https://github.com/{REPO}/actions/runs/{args.run_id}/attempts/{attempt}'
    jobs = github.pages(run_path + f'/attempts/{attempt}/jobs', 'jobs')
    artifacts = github.pages(run_path + '/artifacts', 'artifacts')
    require(len({j.get('id') for j in jobs}) == len(jobs), 'Duplicate job identity')
    for job in jobs:
        require(job.get('run_id') == args.run_id and job.get('run_attempt') == attempt
                and job.get('head_sha') == run['head_sha'], 'Job execution identity conflict')
    workflow = git_file(root, run['head_sha'], WORKFLOW)
    entries, definition = matrix_entries(workflow)
    output = output_root / f'{args.run_id}-{attempt}'
    require(not output.exists(), 'Evidence output already exists; refusing to overwrite')
    output.mkdir(parents=True)

    def save(path, content):
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content)
        return path.relative_to(root).as_posix()

    def save_json(path, value):
        return save(path, (json.dumps(value, indent=2, sort_keys=True) + '\n').encode())

    run_local = save_json(output / 'github-run.json', run)
    jobs_local = save_json(output / 'github-jobs.json', jobs)
    save_json(output / 'github-artifacts.json', artifacts)
    workflow_local = save(output / 'original-workflow.yml', workflow)
    packet = {'run_id': args.run_id, 'run_attempt': attempt, 'run_url': run_url, 'jobs': []}
    used_jobs = set()
    for entry in entries:
        label = entry['label']
        matches = [j for j in jobs if re.search(r'(?<![A-Za-z0-9_-])' + re.escape(label) + r'(?![A-Za-z0-9_-])', j.get('name', ''))]
        require(len(matches) <= 1, 'Ambiguous matrix job identity')
        job = matches[0] if matches else None
        if job:
            require(job['id'] not in used_jobs, 'Job matches multiple matrix entries')
            used_jobs.add(job['id'])
        job_dir = output / label
        result = {'run': run, 'job': job, 'matrix': entry, 'artifact': None, 'receipt': None,
                  'receipt_path': None, 'receipt_sha256': None, 'source_bindings': {}, 'original_source_files': {}, 'evidence': [], 'validation_errors': [],
                  'environment': {'runner_labels': job.get('labels', []) if job else [],
                                  'runner_name': job.get('runner_name') if job else None,
                                  'runner_os': definition.get('runs-on'), 'browser': 'chromium',
                                  'postgres': (definition.get('services', {}).get('postgres', {}) or {}).get('image'),
                                  'isolation': 'isolated synthetic PostgreSQL fixture; no production acceptance',
                                  'source': 'original workflow and GitHub job metadata'}}
        packet['jobs'].append(result)

        def evidence(kind, path, url=run_url):
            result['evidence'].append({'kind': kind, 'path': path, 'sha256': digest((root / path).read_bytes()), 'url': url})

        evidence('github-run', run_local)
        evidence('github-jobs', jobs_local)
        evidence('original-workflow', workflow_local)
        result['source_bindings'][workflow_local] = digest(workflow)
        if not job:
            result['validation_errors'].append('Matrix job absent; metadata only, not run')
            continue
        try:
            require(job.get('status') == 'completed', 'Job is not complete')
            start, finish = timestamp(job.get('started_at')), timestamp(job.get('completed_at'))
            require(start <= finish, 'Job timestamps conflict')
            name = 'login-session-race-' + label
            candidates = [a for a in artifacts if a.get('name') == name + f'-attempt-{attempt}']
            if not candidates and attempt == 1:
                candidates = [a for a in artifacts if a.get('name') == name
                              and start <= timestamp(a.get('created_at')) <= finish]
            require(len(candidates) <= 1, 'Conflicting artifacts for matrix attempt')
            require(len(candidates) == 1, 'Artifact absent or cannot be bound to this attempt; metadata only')
            artifact = candidates[0]
            result['artifact'] = artifact
            require(start <= timestamp(artifact.get('created_at')) <= finish, 'Artifact creation outside job bounds')
            require(not artifact.get('expired'), 'Artifact expired; metadata only')
            identity = artifact.get('workflow_run') or {}
            require(identity.get('id') == args.run_id and identity.get('head_sha') == run['head_sha']
                    and identity.get('repository_id') == repository['id']
                    and identity.get('head_repository_id') == repository['id'], 'Artifact run identity conflict')
            artifact_id = artifact.get('id')
            require(isinstance(artifact_id, int) and artifact_id > 0, 'Invalid artifact identity')
            archive = github.read(prefix + f'/actions/artifacts/{artifact_id}/zip')
            if artifact.get('digest'):
                require(artifact['digest'] == 'sha256:' + digest(archive), 'Artifact archive digest mismatch')
            archive_path = save(job_dir / 'artifact.zip', archive)
            evidence('github-artifact-archive', archive_path, f'https://github.com/{REPO}/actions/runs/{args.run_id}/artifacts/{artifact_id}')
            extract_zip(archive, job_dir / 'artifact')
            for path in sorted((job_dir / 'artifact').rglob('*')):
                if path.is_file():
                    evidence('artifact-file', path.relative_to(root).as_posix())
            receipts = list((job_dir / 'artifact').rglob('results.json'))
            require(len(receipts) == 1, 'Expected exactly one original results.json receipt')
            receipt_path = receipts[0]
            result['receipt_path'] = receipt_path.relative_to(root).as_posix()
            result['receipt_sha256'] = digest(receipt_path.read_bytes())
            receipt = json.loads(receipt_path.read_bytes())
            require(isinstance(receipt, dict), 'Receipt is not an object')
            result['receipt'] = receipt
            checks = [
                (receipt.get('commit') == entry['source'], 'Receipt source commit mismatch'),
                (receipt.get('workflow_run_sha') == run['head_sha'], 'Receipt workflow commit mismatch'),
                (receipt.get('workflow_id') == 'auth.credential-login', 'Receipt workflow identity mismatch'),
                (start <= timestamp(receipt.get('started_at')) <= timestamp(receipt.get('finished_at')) <= finish,
                 'Receipt execution outside job bounds'),
            ]
            result['validation_errors'].extend(message for valid, message in checks if not valid)
            bindings = receipt.get('source_bindings')
            require(isinstance(bindings, dict) and bindings, 'Receipt source bindings missing')
            require(len(bindings) <= MAX_SOURCES, 'Receipt contains too many source bindings')
            require(SCRIPT in bindings, 'Receipt patched runner source binding missing')
            restored_bytes = 0
            for path, expected in bindings.items():
                safe_path(path)
                require(isinstance(expected, str) and DIGEST.fullmatch(expected), 'Invalid receipt source hash')
                if path == SCRIPT:
                    for original_path, kind in ((SCRIPT, 'original-runner'), (PATCH, 'original-runner-patch')):
                        original_content = git_file(root, run['head_sha'], original_path)
                        original_local = save(job_dir / 'reconstruction' / original_path, original_content)
                        evidence(kind, original_local, f'https://github.com/{REPO}/blob/{run["head_sha"]}/{original_path}')
                    content = patched_script(root, run['head_sha'])
                else:
                    content = git_file(root, entry['source'], path)
                restored_bytes += len(content)
                require(restored_bytes <= MAX_BYTES, 'Restored sources exceed size limit')
                local = save(job_dir / 'sources' / path, content)
                actual = digest(content)
                result['source_bindings'][local] = actual
                result['original_source_files'][path] = local
                evidence('restored-source', local, f'https://github.com/{REPO}/blob/{run["head_sha"] if path == SCRIPT else entry["source"]}/{path}')
                if actual != expected:
                    result['validation_errors'].append('Restored source hash mismatch: ' + path)
            if receipt.get('browser'):
                result['environment']['browser'] = receipt['browser']
            if receipt.get('browser_version'):
                result['environment']['browser_version'] = receipt['browser_version']
        except (EvidenceError, ValueError, UnicodeError, OSError) as exc:
            # Messages intentionally exclude response bodies, signed URLs and tokens.
            message = str(exc) if isinstance(exc, EvidenceError) else 'Evidence parsing or local file processing failed'
            result['validation_errors'].append(message)
    save_json(output / 'packet.json', packet)
    print(json.dumps({'packet': (output / 'packet.json').relative_to(root).as_posix(),
                      'run_id': args.run_id, 'run_attempt': attempt, 'jobs': len(packet['jobs']),
                      'blocked_jobs': sum(bool(j['validation_errors']) for j in packet['jobs'])}))


if __name__ == '__main__':
    try:
        main()
    except EvidenceError as exc:
        print('Evidence collection blocked: ' + str(exc), file=sys.stderr)
        sys.exit(2)
