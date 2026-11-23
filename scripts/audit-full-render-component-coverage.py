"""Index the supplied Fuse archives for the R01–R25 coverage gate."""
import argparse
from collections import Counter
import csv
from hashlib import sha256
from io import BytesIO
import json
from pathlib import Path
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
SKELETON = 'Fuse-React-v17.0.0-vitejs-skeleton.zip'
MUI_ROOT = '/material-ui-components/'
FAMILY_TASKS = {
    'R06': 'app-bar bottom-navigation breadcrumbs',
    'R16': 'accordion menus popover popper tabs tooltips',
    'R17': 'alert backdrop dialogs drawers modal snackbars',
    'R18': 'autocomplete button-group buttons checkboxes floating-action-button links number-field radio-buttons rating selects slider speed-dial steppers switches text-fields toggle-button transfer-list',
    'R19': 'avatars badges cards chips dividers image-list lists pagination paper table timeline',
    'R20': 'progress skeleton transitions',
    'R21': 'typography',
    'R22': 'css-baseline init-color-scheme-script',
    'R23': 'box container grid grid-legacy masonry stack',
}
FAMILY_QUEUE = {family: task for task, families in FAMILY_TASKS.items() for family in families.split()}


def classify(path):
    if MUI_ROOT in path:
        family = path.split(MUI_ROOT, 1)[1].split('/')[0]
        return 'Component example source', family, FAMILY_QUEUE[family], 'NOT MATCHED'
    if '/apps/' in path or '/dashboards/' in path:
        return 'Demo app or dashboard source', '', '', 'BLOCKED'
    if '/configurator/' in path or '/FuseSettings/' in path or '/FuseThemeSelector/' in path:
        return 'Theme settings source', '', 'R13–R15, R22', 'NOT MATCHED'
    if '/theme-layouts/' in path or '/FuseLayout/' in path or '/FuseNavigation/' in path:
        return 'Shell or navigation source', '', 'R01–R12', 'NOT MATCHED'
    if '/tiptap/' in path:
        return 'Editor source', '', 'R18', 'NOT MATCHED'
    if '/data-table/' in path:
        return 'Table source', '', 'R19', 'NOT MATCHED'
    if path.endswith('.tsx'):
        return 'Other component or route candidate', '', 'R25', 'NOT MATCHED'
    return 'Supporting source', '', '', ''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('archive', type=Path)
    parser.add_argument('--csv', required=True, type=Path)
    args = parser.parse_args()
    catalog = json.loads((ROOT / 'docs/appearance/component-catalogue-reference-audit.json').read_text())
    historical = json.loads((ROOT / 'packages/primecare_ui/catalogs/fuse-skeleton.inventory.json').read_text())
    expected = {row['source']: row['sha256'] for row in historical['files']}
    assert set(FAMILY_QUEUE) == {r['family'] for r in catalog['families']}
    assert sha256(args.archive.read_bytes()).hexdigest() == catalog['sourceArchiveSha256']
    expected_names = {f'Fuse-React-v17.0.0-{platform}-{variant}.zip' for platform in ('vitejs', 'nextjs') for variant in ('skeleton', 'demo')}
    bundles = Counter()
    families = Counter()
    source_roles = Counter()
    skeleton = {}
    with ZipFile(args.archive) as supplied, args.csv.open('w', newline='', encoding='utf-8-sig') as stream:
        assert {name for name in supplied.namelist() if name.endswith('.zip')} == expected_names
        writer = csv.writer(stream)
        writer.writerow(['Bundle', 'Source path', 'Source SHA-256', 'Source role', 'Component family', 'Review queue', 'Visual status'])
        for name in sorted(expected_names):
            with ZipFile(BytesIO(supplied.read(name))) as archive:
                paths = [p for p in archive.namelist() if p.startswith('src/') and not p.endswith('/')]
                assert len(paths) == len(set(paths)), name
                for path in sorted(paths):
                    digest = sha256(archive.read(path)).hexdigest()
                    role, family, queue, status = classify(path)
                    writer.writerow([name, path, digest, role, family, queue, status])
                    source_roles[role] += 1
                    bundles[name] += 1
                    if family and path.endswith(('.ts', '.tsx')):
                        families[family] += 1
                    if name == SKELETON:
                        skeleton[path] = digest
    assert families == {r['family']: r['physicalExamples'] for r in catalog['families']}
    print(json.dumps({'bundles': bundles, 'sourceRoles': source_roles, 'familyCount': len(families),
                      'namedExampleFiles': sum(families.values()),
                      'historicalViteMissing': sorted(expected.keys() - skeleton.keys()),
                      'historicalViteAdded': sorted(skeleton.keys() - expected.keys()),
                      'historicalViteChanged': sorted(p for p in expected.keys() & skeleton.keys() if expected[p] != skeleton[p])},
                     indent=2))


if __name__ == '__main__':
    main()
