#!/usr/bin/env python3
"""Migrate reviewed Material TextField constructors to PrimeTextField."""
import argparse
import hashlib
import importlib.util
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = Path(__file__).with_name('shared-text-fields-manifest.json')
spec = importlib.util.spec_from_file_location('buttons', Path(__file__).with_name('migrate-shared-buttons.py'))
buttons = importlib.util.module_from_spec(spec); spec.loader.exec_module(buttons)
boundary = buttons.text.boundary
CALL = re.compile(r'(?<![\w.])TextField\s*\(')
PRIME_CALL = re.compile(r'(?<![\w.])PrimeTextField\s*\(')
CORE_IMPORT = "import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextField;\n"
APP_IMPORT = "import 'package:primecare_ui/primecare_ui.dart' show PrimeTextField;\n"
BROAD_UI_IMPORT = re.compile(r"\bimport\s+['\"]package:primecare_ui/primecare_ui\.dart['\"]\s*;")
ALLOWED = {'key','controller','focusNode','decoration','keyboardType','maxLines','maxLength',
           'enabled','autofocus','obscureText','onChanged','onSubmitted'}
CLEANUPS = {
    'apps/primecare_governance/lib/core/ui/app_components.dart':
        ("PrimeTextField(key: const Key('app_components_textfield_input_1'), \n",
         "PrimeTextField(key: const Key('app_components_textfield_input_1'),\n"),
    'apps/primecare_governance/lib/governance/widgets/governance_dashboard.dart':
        ("PrimeTextField(key: const Key('governance_dashboard_textfield_input_1'), \n",
         "PrimeTextField(key: const Key('governance_dashboard_textfield_input_1'),\n"),
}


def digest(source): return hashlib.sha256(source.encode()).hexdigest()


def required_import(path, source):
    if path.startswith('packages/flutter_core/'): return CORE_IMPORT
    if BROAD_UI_IMPORT.search(source): return ''
    return APP_IMPORT


def argument_names(code, parts):
    names=[]
    for start,end in parts:
        if not code[start:end].strip():
            continue
        match=re.match(r'\s*(\w+)\s*:',code[start:end])
        if not match:return None
        names.append(match[1])
    return names if len(names)==len(set(names)) else None


def replace_text_fields(source, expected):
    code=boundary.executable_code(source)
    if re.search(r'\bpart\b|\b(?:class|typedef|mixin|enum|extension)\s+(?:TextField|PrimeTextField)\b',code):return source,0
    if re.search(r'\b(?:Widget|dynamic|Object|Function)\s+(?:TextField|PrimeTextField)\s*(?:\(|=)',code):return source,0
    calls=list(CALL.finditer(code))
    if len(calls)!=expected:return source,0
    for call in calls:
        parsed=buttons.arguments(code,call.end())
        names=argument_names(code,parsed[0]) if parsed else None
        if names is None or not set(names)<=ALLOWED:return source,0
    for call in reversed(calls):
        source=source[:call.start()]+'PrimeTextField'+source[call.start()+len('TextField'):]
    return source,expected


def migrate_source(path,source,original_sha,expected):
    if digest(source)!=original_sha:return source,0
    updated,count=replace_text_fields(source,expected)
    if not count:return source,0
    import_line=required_import(path,source)
    if import_line:
        position=boundary.executable_code(updated).find('import ')
        if position<0:return source,0
        updated=updated[:position]+import_line+updated[position:]
    cleanup=CLEANUPS.get(path)
    if cleanup:
        if updated.count(cleanup[0])!=1:return source,0
        updated=updated.replace(cleanup[0],cleanup[1],1)
    return updated,count


def reverse_source(path,source,expected):
    cleanup=CLEANUPS.get(path)
    if cleanup:
        if source.count(cleanup[1])!=1:return source,0
        source=source.replace(cleanup[1],cleanup[0],1)
    code=boundary.executable_code(source);calls=list(PRIME_CALL.finditer(code))
    if len(calls)!=expected:return source,0
    for call in reversed(calls):
        source=source[:call.start()]+'TextField'+source[call.start()+len('PrimeTextField'):]
    for import_line in (CORE_IMPORT,APP_IMPORT):
        if import_line in source:source=source.replace(import_line,'',1)
    return source,expected


def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--root',type=Path,default=ROOT)
    parser.add_argument('--offset',type=int,default=0);parser.add_argument('--limit',type=int);parser.add_argument('--apply',action='store_true');args=parser.parse_args()
    if args.offset<0 or args.limit is not None and args.limit<0:parser.error('offset and limit must be non-negative')
    root=args.root.resolve();manifest=json.loads(MANIFEST_PATH.read_text());entries=sorted(manifest.items())[args.offset:]
    if args.limit is not None:entries=entries[:args.limit]
    files=[];calls=0
    for relative,(sha,expected) in entries:
        path=root/relative
        if path.is_symlink() or not path.resolve().is_relative_to(root):parser.error(f'unsafe manifest path: {relative}')
        source=path.read_text();updated,count=migrate_source(relative,source,sha,expected)
        if count:
            if args.apply:path.write_text(updated)
            files.append(relative);calls+=count
    print(json.dumps({'applied':args.apply,'textFields':calls,'files':files},indent=2))


if __name__=='__main__':main()
