"""Compose exact source receipts when later reviewed migrations touch a library."""
import hashlib
import json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]


def before_control_extensions(source,path):
    manifest=ROOT/'scripts/shared-control-extensions-manifest.json'
    if not manifest.exists():return source
    row=next((r for r in json.loads(manifest.read_text()) if r['path']==path),None)
    if row is None:return source
    edits=[];delta=0
    for edit in row['edits']:
        begin=edit['begin']+delta
        if source[begin:begin+len(edit['new'])]!=edit['new']:
            raise AssertionError('Control extension output drift: '+path)
        edits.append((begin,begin+len(edit['new']),edit['old']))
        delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for a,b,value in reversed(edits):source=source[:a]+value+source[b:]
    if hashlib.sha256(source.encode()).hexdigest()!=row['sha256']:
        raise AssertionError('Control extension input drift: '+path)
    return source
