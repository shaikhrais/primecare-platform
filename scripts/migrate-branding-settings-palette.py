#!/usr/bin/env python3
"""Apply reviewed branding settings semantic palette edits only to exact original source revisions."""
import argparse
import hashlib
import json
from pathlib import Path

MANIFEST = json.loads(Path(__file__).with_name('branding-settings-palette-manifest.json').read_text())
BY_HASH = {row['sha256']: row for row in MANIFEST}


def migrate(source):
    row = BY_HASH.get(hashlib.sha256(source.encode()).hexdigest())
    if row is None:
        return source, 0
    edits = row['edits']
    if any(source[e['begin']:e['end']] != e['old'] for e in edits):
        return source, 0
    for edit in reversed(edits):
        source = source[:edit['begin']]+edit['new']+source[edit['end']:]
    return source, row['calls']


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    p.add_argument('--offset',type=int,default=0)
    p.add_argument('--limit',type=int,default=100)
    p.add_argument('--apply',action='store_true')
    a=p.parse_args()
    if a.offset<0 or a.limit<1:p.error('offset must be nonnegative and limit positive')
    root=a.root.resolve();files=[];count=0
    for row in MANIFEST[a.offset:a.offset+a.limit]:
        path=root/row['path']
        if path.is_symlink() or not path.resolve().is_relative_to(root) or not path.is_file():continue
        updated,n=migrate(path.read_text())
        if n:
            if a.apply:path.write_text(updated)
            files.append(row['path']);count+=n
    print(json.dumps({'applied':a.apply,'colors':count,'files':files},indent=2))


if __name__=='__main__':main()
