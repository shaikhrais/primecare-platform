#!/usr/bin/env python3
"""Read-only tracked-file inventory. Never infer retirement from modification age."""
import argparse
import collections
import csv
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
ARCHIVE = 'generated_screen_backup_before_template_reset/'

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir', required=True)
    args = parser.parse_args()
    output = Path(args.output_dir).resolve()
    output.mkdir(parents=True, exist_ok=True)
    paths = subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0')[:-1]
    revision = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT).decode().strip()
    rows = []
    hashes = collections.defaultdict(list)
    for name in sorted(paths):
        path = ROOT / name
        if not path.is_file():
            continue
        data = path.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        hashes[digest].append(name)
        text = '' if b'\0' in data[:8192] else data.decode('utf-8', errors='replace')
        declarations = re.findall(r'^\s*(?:export\s+)?(?:abstract\s+)?(?:class|enum|def|function|interface)\s+(\w+)', text, re.M)[:12]
        title = next((line.lstrip('# ').strip()[:160] for line in text.splitlines()[:30] if line.startswith('# ')), '')
        area = name.split('/')[0] if '/' in name else 'root'
        if name.startswith(ARCHIVE):
            purpose = 'Pre-template-reset backup; preserve unique behavior until migration is verified'
            decision = 'review-backup'
        elif '/__pycache__/' in name or name.endswith('.pyc'):
            purpose = 'Regenerable Python interpreter cache'
            decision = 'review-regenerable-cache'
        elif area == 'scratch':
            purpose = 'Historical development utility; inspect effects and callers before removal'
            decision = 'review-utility'
        else:
            purpose = title or ('Definitions: ' + ', '.join(declarations) if declarations else 'Repository asset in ' + area)
            decision = 'retain-pending-review'
        rows.append(dict(path=name, area=area, bytes=len(data), sha256=digest,
                         purpose=purpose, evidence='content heading/declarations or path classification; not a semantic review',
                         decision=decision, identical_active_copy='', references='not assessed',
                         replacement_verified=False, safe_to_delete=False))
    for row in rows:
        if row['path'].startswith(ARCHIVE):
            row['identical_active_copy'] = ';'.join(p for p in hashes[row['sha256']] if not p.startswith(ARCHIVE))
    with (output / 'file-retirement-inventory.csv').open('w', newline='') as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    summary = dict(source_commit=revision, inventoried_files=len(rows),
                   areas=dict(collections.Counter(r['area'] for r in rows)),
                   backup_files=sum(r['path'].startswith(ARCHIVE) for r in rows),
                   backup_files_with_identical_active_copy=sum(bool(r['identical_active_copy']) for r in rows),
                   semantic_review_complete=False,
                   note='Duplicate bytes alone do not establish safe removal. No files were deleted by this audit.')
    (output / 'file-retirement-summary.json').write_text(json.dumps(summary, indent=2) + '\n')
    print(json.dumps(summary, indent=2))

if __name__ == '__main__':
    main()
