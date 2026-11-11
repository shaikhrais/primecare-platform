#!/usr/bin/env python3
"""Bind exact premium-template primary brand consumers to the active primary token.

The existing premium-header migration establishes 6366F1 as this template's
primary brand role. Match four known consumers, not other chart/status accents.
Dry run default; offset/limit control deterministic library batches.
"""
import argparse
import hashlib
import importlib.util
import json
import re
from pathlib import Path
spec = importlib.util.spec_from_file_location('theme', Path(__file__).with_name('migrate-generated-theme.py'))
t = importlib.util.module_from_spec(spec);spec.loader.exec_module(t)
SNIPPETS = ["_StatCard(\n              title: 'Telemetry Node Health', // .tr() LocaleKeys.\n              value: '99.98%', // .tr() LocaleKeys.\n              change: '+0.02%', // .tr() LocaleKeys.\n              isPositive: true,\n              icon: Icons.hub,\n              color: Color(0xFF6366F1),\n            )", "_TelemetryPanel(\n                    modelName: 'AppNotification',\n                    data: data,\n                    themeColor: const Color(0xFF6366F1),\n                  )", "QuickActionItem(\n                  label: 'Purge Buffers', // .tr() LocaleKeys.\n                  icon: Icons.cleaning_services,\n                  color: const Color(0xFF6366F1),\n                  onTap: () {},\n                )", "PortalActivityItem(\n                  title: 'Zero-Trust Audit Log', // .tr() LocaleKeys.\n                  description: 'Verified tenant credentials with secure authentication.', // .tr() LocaleKeys.\n                  time: '1h ago', // .tr() LocaleKeys.\n                  icon: Icons.lock,\n                  color: Color(0xFF6366F1),\n                )"]
HELPER_HASHES = {'_StatCard': 'a19f390a63b728a5e274f574d58cb5cde2166a53eeb86dfc1913ac4f784db8bd', '_TelemetryPanel': '25e83e002878bad31967f27e4a14133a46f93481f7baf660d011f25ff84d0740'}
PATTERNS = []
for snippet in SNIPPETS:
    value = re.search(r'(?:const )?Color\(0xFF6366F1\)', snippet)[0]
    pattern = re.escape(snippet).replace(re.escape(value), r'(?P<color>(?:const )?Color\(0xFF6366F1\))')
    if snippet.startswith('_TelemetryPanel('):
        pattern = pattern.replace(re.escape("'AppNotification'"), r"'(?:\\[^$\r\n]|[^'\\$\r\n])*'")
    PATTERNS.append(re.compile(pattern))


def planned_edits(source):
    code = t.boundary.executable_code(source)
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b',code):
        return [],0
    for package in ('flutter/material.dart','primecare_ui/primecare_ui.dart'):
        pattern=r"\bimport\s+(['\"])package:"+re.escape(package)+r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern,source)):
            return [],0
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:Color|QuickActionItem|PortalActivityItem)\b|\b(?:Color|QuickActionItem|PortalActivityItem|_StatCard|_TelemetryPanel)\s*=',code):
        return [],0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:Color|QuickActionItem|PortalActivityItem|_StatCard|_TelemetryPanel)\s*\(',code):
        return [],0
    if any(len(re.findall(r'\bclass\s+'+re.escape(name)+r'\b',code))!=1 for name in ('_StatCard','_TelemetryPanel')):
        return [],0
    for name,endname in [('_StatCard','_TelemetryPanel'),('_TelemetryPanel','_AuditPanel')]:
        begin=source.find('class '+name+' ');end=source.find('class '+endname+' ',begin)
        if min(begin,end)<0 or not code[begin:].startswith('class '+name+' ') or hashlib.sha256(source[begin:end].strip().encode()).hexdigest()!=HELPER_HASHES[name]:
            return [],0
    frames=t.frames(code);by_open={f[0]:f for f in frames}
    consts=[(m.start(),m.start()+len('const'),by_open.get(m.end()-1)) for m in t.CONST_CALL.finditer(code)]
    edits=[];removed=set();count=0
    for method in re.finditer(r'\bWidget\s+buildScreen\(BuildContext context, WidgetRef ref\)\s*{',code):
        body=by_open.get(method.end()-1)
        if not body or not body[3] or body[3][3] is not None:
            continue
        owner=body[3]
        if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\s*$',code[max(0,owner[0]-150):owner[0]]):
            continue
        prefix=code[body[0]+1:body[1]]
        if not re.match(r'\s*final theme = context\.theme;',prefix) or len(re.findall(r'\btheme\s*=',prefix))!=1 or re.search(r'\b(?:const|var|final)\s+\w+\s+theme\b|\bconst\s+\w+(?:\s+\w+)?\s*=|[(,]\s*theme\s*[,)]|\btheme\s*=>',prefix):
            continue
        for pattern in PATTERNS:
            for match in pattern.finditer(source,body[0]+1,body[1]):
                if not code[match.start():].startswith(source[match.start():source.index('(',match.start())]) or code[:match.start()].rstrip().endswith('.'):
                    continue
                start,end=match.span('color');edits.append((start,end,'theme.colors.primary'));count+=1
                for begin,finish,frame in consts:
                    if frame and body[0]<begin<start and frame[1]>=end-1:
                        removed.add((begin,finish,''))
    return sorted(edits+list(removed)),count


def migrate(source):
    edits,count=planned_edits(source)
    for begin,end,value in reversed(edits):
        source=source[:begin]+value+source[end:]
    return source,count


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    p.add_argument('--offset',type=int,default=0);p.add_argument('--limit',type=int,default=100)
    p.add_argument('--apply',action='store_true');a=p.parse_args()
    if a.offset<0 or a.limit<1:p.error('offset must be nonnegative and limit positive')
    root=a.root.resolve();files=[];colors=0
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[a.offset:a.offset+a.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):continue
        result,count=migrate(path.read_text())
        if count:
            if a.apply:path.write_text(result)
            files.append(path.relative_to(root).as_posix());colors+=count
    print(json.dumps({'applied':a.apply,'colors':colors,'files':files}))


if __name__=='__main__':main()
