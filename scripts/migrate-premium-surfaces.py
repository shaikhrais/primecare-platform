#!/usr/bin/env python3
"""Migrate known premium-template neutral surface roles to inherited theme tokens.

Only the existing PremiumFeature template and its widget build methods qualify.
Accent/status/chart colors and custom contexts stay unchanged. Dry run by default;
--offset/--limit split the deterministic library list into separate commits.
"""
import argparse
import importlib.util
import json
import re
from pathlib import Path

spec=importlib.util.spec_from_file_location('theme',Path(__file__).with_name('migrate-generated-theme.py'))
theme=importlib.util.module_from_spec(spec)
spec.loader.exec_module(theme)
COLOR=re.compile(r'(?<![\w.])(?:Color\s*\(\s*0xFF([0-9A-Fa-f]{6})\s*\)|Colors\s*\.\s*(white|red|blueGrey\s*\.\s*shade400|blueGrey\s*\.\s*shade50|grey\s*\.\s*shade50|grey\s*\.\s*shade100))(?!\w)')
RULES={
    ('Scaffold','backgroundColor','F8FAFC'):'background',
    # The generated PREMIUM badge uses this exact foreground/tinted surface pair.
    ('BoxDecoration','color','6366F1'):'primary',
    ('TextStyle','color','6366F1'):'primary',
    ('AppBar','backgroundColor','white'):'surface',
    ('BoxDecoration','color','white'):'surface',
    ('BoxDecoration','color','grey.shade50'):'surfaceContainerLow',
    ('Container','color','grey.shade50'):'surfaceContainerLow',
    ('Border.all','color','grey.shade100'):'outline',
    ('BorderSide','color','blueGrey.shade50'):'outline',
}
for color in ('0F172A','1E293B'):
    RULES[('TextStyle','color',color)]='onSurface'
for color in ('64748B','94A3B8','blueGrey.shade400'):
    RULES[('TextStyle','color',color)]='onSurfaceVariant'
    RULES[('Icon','color',color)]='onSurfaceVariant'


def migrate(source):
    code=theme.boundary.executable_code(source)
    if not re.search(r'\bclass\s+PremiumFeature\d+\s+extends\s+GovernedConsumerWidget\b',code):
        return source,0
    for path in ('flutter/material.dart','primecare_ui/primecare_ui.dart'):
        pattern=r"\bimport\s+(['\"])package:"+re.escape(path)+r'\1\s*;'
        if not any(code[m.start():].startswith('import') for m in re.finditer(pattern,source)):
            return source,0
    if re.search(r'\b(?:class|typedef|mixin|enum|as)\s+(?:Color|Colors|Text|TextStyle|Icon|BoxDecoration|Scaffold|AppBar|Border|BorderSide)\b',code):
        return source,0
    if re.search(r'\b(?:Color|Colors|Text|TextStyle|Icon|BoxDecoration|Scaffold|AppBar|Border|BorderSide)\s*=',code):
        return source,0
    all_frames=theme.frames(code)
    by_open={f[0]:f for f in all_frames}
    consts=[(m.start(),m.start()+len('const'),by_open.get(m.end()-1)) for m in theme.CONST_CALL.finditer(code)]
    edits=[];removed=set();count=0
    for method in re.finditer(r'\bWidget\s+build(?:Screen)?\s*\(BuildContext\s+context(?:,\s*WidgetRef\s+ref)?\)\s*{',code):
        body=by_open.get(method.end()-1)
        if not body or not body[3] or body[3][3] is not None:
            continue
        body_code=code[body[0]+1:body[1]]
        bound=bool(re.match(r'\s*final\s+theme\s*=\s*context\.theme\s*;',body_code))
        if len(re.findall(r'\btheme\s*=',body_code)) != int(bound) or re.search(r'\bconst\s+\w+(?:\s+\w+)?\s*=',body_code):
            continue
        if not bound and re.search(r'\btheme\b',body_code):
            continue
        if re.search(r'\bWidget\s+build(?:Screen)?\s*\(',body_code):
            continue
        before=count
        for match in COLOR.finditer(code,body[0]+1,body[1]):
            parents=[f for f in all_frames if f[0] < match.start() < f[1]]
            parent=max(parents,key=lambda f:f[0]) if parents else None
            if not parent:
                continue
            named=re.search(r'\b(\w+)\s*:\s*(?:const\s*)?$',code[parent[0]+1:match.start()])
            value=match[1].upper() if match[1] else re.sub(r'\s+','',match[2])
            role=RULES.get((parent[2],named[1],value)) if named else None
            # This exact generated diagnostic identifies the existing error role.
            # Decorative red labels and arbitrary TextStyle uses remain untouched.
            text_parent=parent[3]
            if not role and named and parent[2]=='TextStyle' and named[1]=='color' and value=='red' and text_parent and text_parent[2]=='Text' and not re.match(r'\s*(?:\.|\[)',code[match.end():]):
                label=source[text_parent[0]:parent[0]]
                if re.match(r"^\(\s*(['\"])Hydration Failure: \$error\1\s*,",label):
                    role='error'
            if not role:
                continue
            edits.append((match.start(),match.end(),'theme.colors.'+role));count+=1
            for begin,end,frame in consts:
                if frame and body[0] < begin <= match.start() and frame[1] >= match.end()-1:
                    removed.add((begin,end,''))
        if count > before and not bound:
            edits.append((body[0]+1,body[0]+1,'\n    final theme = context.theme;'))
    for begin,end,replacement in sorted(edits+list(removed),reverse=True):
        source=source[:begin]+replacement+source[end:]
    return source,count


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    parser.add_argument('--offset',type=int,default=0)
    parser.add_argument('--limit',type=int,default=100)
    parser.add_argument('--apply',action='store_true')
    args=parser.parse_args()
    if args.offset < 0 or args.limit < 1:
        parser.error('offset must be nonnegative and limit positive')
    root=args.root.resolve();files=[];calls=0
    for path in sorted((root/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))[args.offset:args.offset+args.limit]:
        if path.is_symlink() or not path.resolve().is_relative_to(root):
            continue
        updated,count=migrate(path.read_text())
        if count:
            if args.apply:
                path.write_text(updated)
            calls+=count;files.append(path.relative_to(root).as_posix())
    print(json.dumps({'applied':args.apply,'colors':calls,'files':files},indent=2))


if __name__ == '__main__':
    main()
