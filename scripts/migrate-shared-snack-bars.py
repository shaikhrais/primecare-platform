#!/usr/bin/env python3
"""Migrate the exact reviewed SnackBar consumers to PrimeSnackBar."""
import argparse
import hashlib
import json
import re
from pathlib import Path

SPECS = {
    'apps/primecare_governance/lib/governance/widgets/governance_patch_manager.dart': ('f670bfb92f83d1467fabe508228e93c945308d098d40f2256ccd9030124fed13', 1, 'ui'),
    'apps/primecare_governance/lib/governance/widgets/governance_issue_table.dart': ('d7ba6e3b63e9985bf0851f6cd5ffca90d919bcfae229df0daa55c2bb6fb59873', 2, None),
    'apps/primecare_governance/lib/governance/widgets/governance_dashboard.dart': ('d6ee38b97ebbf69f889c5d035914008b3c4d175ae398aeac8f09afc722d857d9', 2, None),
    'apps/primecare_governance/lib/features/system_governance/app_entry_form.dart': ('20539da303f71dc21af8d8ad42027d4d250465828009e920dd9d04d420f80c0d', 1, None),
    'packages/flutter_core/lib/widgets/clinical_article_detail_dialog.dart': ('2b0cff6d4aac8c5c3bc8f0f2078871599c0e07dcf331bd13f343203c0b2e915c', 1, 'foundation'),
    'packages/flutter_core/lib/manifest/action_manifest.dart': ('cf9f08d30672df5eed8cbb2dab9122145a4acb1c054601a4c31c64d46ddb3c5a', 1, 'foundation'),
    'packages/flutter_core/lib/manifest/aura_action_manifest.dart': ('fa6ac8cda8712cb5d0201dc10cc32ebd4fadc77ee4bad5191cabf2fb7a804813', 1, 'foundation'),
    'packages/flutter_core/lib/routes/governance_navigator.dart': ('b6d11fa02e0f09d5e879ef961853b001ebe29a3e0b8f69159b8941f6e0b63a64', 1, 'foundation'),
    'packages/flutter_core/lib/registry/widgets/governance_master_layout.dart': ('005cfbb3143f655dbafd9924af940383641487a083017b13e58bd5f8e1390e91', 1, 'foundation'),
    'packages/flutter_core/lib/registry/widgets/theme_center_panel.dart': ('da09b5858ba05fa6d7b174f69e9840eb6fcf6d20613c463c8494ae82b4ca58a0', 3, 'foundation'),
    'packages/flutter_core/lib/security/shortcuts/quick_access_manager.dart': ('87de936106672d6511e92c872a1a373e65eaf7d22640ffe3ebb91c1608b4af5b', 2, 'foundation'),
}
CALL = re.compile(r'(?<![\w.])SnackBar(?P<space>\s*)\(')
SHARED_CALL = re.compile(r'(?<![\w.])PrimeSnackBar(?P<space>\s*)\(')
IMPORTS = {
    'foundation': "import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeSnackBar;\n",
    'ui': "import 'package:primecare_ui/primecare_ui.dart' show PrimeSnackBar;\n",
}

def _insert_import(source, line):
    if line in source:
        return source
    match = re.search(r'^import ', source, re.MULTILINE)
    if match is None:
        raise ValueError('reviewed source has no import anchor')
    return source[:match.start()] + line + source[match.start():]

def migrate_source(path, source):
    spec = SPECS.get(path)
    if spec is None or hashlib.sha256(source.encode()).hexdigest() != spec[0]:
        return source, 0
    updated, count = CALL.subn(lambda m: 'PrimeSnackBar'+m.group('space')+'(', source)
    if count != spec[1]:
        return source, 0
    if spec[2]:
        updated = _insert_import(updated, IMPORTS[spec[2]])
    return updated, count

def reverse_source(path, source):
    spec = SPECS.get(path)
    if spec is None:
        return source, 0
    original, count = SHARED_CALL.subn(lambda m: 'SnackBar'+m.group('space')+'(', source)
    if count != spec[1]:
        return source, 0
    if spec[2]:
        line = IMPORTS[spec[2]]
        if original.count(line) != 1:
            return source, 0
        original = original.replace(line, '', 1)
    if hashlib.sha256(original.encode()).hexdigest() != spec[0]:
        return source, 0
    return original, count

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1])
    parser.add_argument('--offset',type=int,default=0)
    parser.add_argument('--limit',type=int,default=len(SPECS))
    parser.add_argument('--apply',action='store_true')
    args=parser.parse_args()
    if args.offset < 0 or args.limit < 1:
        parser.error('offset must be nonnegative and limit positive')
    root=args.root.resolve(); files=[]; calls=0
    for relative in list(SPECS)[args.offset:args.offset+args.limit]:
        path=root/relative
        if path.is_symlink() or not path.is_file() or not path.resolve().is_relative_to(root):
            continue
        updated,count=migrate_source(relative,path.read_text())
        if not count:
            continue
        if args.apply:
            path.write_text(updated)
        files.append(relative);calls+=count
    print(json.dumps({'applied':args.apply,'calls':calls,'files':files},indent=2))

if __name__ == '__main__':
    main()
