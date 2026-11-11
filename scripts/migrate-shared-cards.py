#!/usr/bin/env python3
"""Migrate exact reviewed Card consumers to PrimeCard."""
import argparse
import hashlib
import json
import re
from pathlib import Path

SPECS = {
    'apps/primecare_governance/lib/core/ui/dev_toolbox.dart': ('272b35bc887e657eb81e24955b130be702c33ed7759b478fea0f99c5f6504c5e', 1, 'ui'),
    'packages/flutter_core/lib/dashboard_widgets/prime_dashboard_widgets.dart': ('245092b8d6c3025f0f5a807120387ba92f86747d17f59d71f5b0be5c6a11f251', 1, 'foundation'),
    'packages/flutter_core/lib/work_modules/prime_work_module.dart': ('aa1344dd3c1db3cc099ebc43bb6edbbe99538935c3797b6e78bb9974c78dfacb', 1, 'foundation'),
    'packages/flutter_core/lib/page/prime_page_template.dart': ('fb4a58467ea067abb4e82962f4ee4fcc0ab7892c5f1295d32ae5e2d7785e1591', 1, 'foundation'),
    'packages/flutter_core/lib/component_catalogue/prime_component_catalogue.dart': ('0383a29b00836a3365051064c76b8c2dec217d0dcaefea504282cc58e0fab26a', 2, 'foundation'),
    'packages/flutter_core/lib/dashboard_pages/prime_record_page.dart': ('68ffbbf38d0d0863fca758b667eb653f1934778370740f654bb73adb7a079141', 1, 'foundation'),
    'packages/flutter_core/lib/dashboard_pages/prime_dashboard_page.dart': ('d017e785da384694c2cd14851c53f1f68f100d21931badefe2f33a4b352afb77', 2, 'foundation'),
    'packages/flutter_core/lib/registry/widgets/responsive_split_dashboard.dart': ('507cce4b6f3feccf8a60264b89ac38e1f7e7e4f3852fd3f3a7804ba72a8d4229', 2, 'foundation'),
    'packages/flutter_core/lib/registry/widgets/theme_settings_drawer.dart': ('1dff2d04d75f672800272b0b970d50563963809b51683f6799635f0a67370a7c', 2, 'foundation'),
}
CALL=re.compile(r'(?<![\w.])Card(?P<space>\s*)\(')
SHARED_CALL=re.compile(r'(?<![\w.])PrimeCard(?P<space>\s*)\(')
IMPORTS={
    'foundation':"import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeCard;\n",
    'ui':"import 'package:primecare_ui/primecare_ui.dart' show PrimeCard;\n",
}

def _insert_import(source,line):
    if line in source:return source
    match=re.search(r'^import ',source,re.MULTILINE)
    if match is None:raise ValueError('reviewed source has no import anchor')
    return source[:match.start()]+line+source[match.start():]

def migrate_source(path,source):
    spec=SPECS.get(path)
    if spec is None or hashlib.sha256(source.encode()).hexdigest()!=spec[0]:return source,0
    updated,count=CALL.subn(lambda m:'PrimeCard'+m.group('space')+'(',source)
    if count!=spec[1]:return source,0
    if spec[2]:updated=_insert_import(updated,IMPORTS[spec[2]])
    return updated,count

def reverse_source(path,source):
    spec=SPECS.get(path)
    if spec is None:return source,0
    original,count=SHARED_CALL.subn(lambda m:'Card'+m.group('space')+'(',source)
    if count!=spec[1]:return source,0
    if spec[2]:
        line=IMPORTS[spec[2]]
        if original.count(line)!=1:return source,0
        original=original.replace(line,'',1)
    if hashlib.sha256(original.encode()).hexdigest()!=spec[0]:return source,0
    return original,count

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    parser.add_argument('--offset',type=int,default=0);parser.add_argument('--limit',type=int,default=len(SPECS));parser.add_argument('--apply',action='store_true')
    args=parser.parse_args()
    if args.offset<0 or args.limit<1:parser.error('offset must be nonnegative and limit positive')
    root=args.root.resolve();files=[];calls=0
    for relative in list(SPECS)[args.offset:args.offset+args.limit]:
        path=root/relative
        if path.is_symlink() or not path.is_file() or not path.resolve().is_relative_to(root):continue
        updated,count=migrate_source(relative,path.read_text())
        if not count:continue
        if args.apply:path.write_text(updated)
        files.append(relative);calls+=count
    print(json.dumps({'applied':args.apply,'calls':calls,'files':files},indent=2))

if __name__=='__main__':main()
