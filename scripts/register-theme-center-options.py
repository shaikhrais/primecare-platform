"""Register Theme Center option resources and export a shared Dart catalog."""
import argparse
import json
from pathlib import Path
import sqlite3
import importlib.util

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / 'packages/flutter_core/lib/theme/theme_center_options_generated.dart'
# Values are registered in governance before runtime export. No UI identifiers change.
VALUES = {
    'font.system': ('System', 'Système', 'Sistema'),
    'font.serif': ('Serif', 'Avec empattements', 'Con remates'),
    'font.monospace': ('Monospace', 'Chasse fixe', 'Monoespaciada'),
    'color.primary': ('Primary color', 'Couleur principale', 'Color principal'),
    'color.primaryContainer': ('Primary container', 'Conteneur principal', 'Contenedor principal'),
    'color.secondary': ('Secondary color', 'Couleur secondaire', 'Color secundario'),
    'color.background': ('Background', 'Arrière-plan', 'Fondo'),
    'color.surface': ('Surface', 'Surface', 'Superficie'),
    'color.text': ('Text', 'Texte', 'Texto'),
    'color.muted': ('Muted text', 'Texte atténué', 'Texto atenuado'),
    'color.border': ('Border', 'Bordure', 'Borde'),
    'color.sidebar': ('Sidebar', 'Barre latérale', 'Barra lateral'),
    'color.topbar': ('Top bar', 'Barre supérieure', 'Barra superior'),
    'color.disabled': ('Disabled text', 'Texte désactivé', 'Texto deshabilitado'),
    'invalidColor': ('Use #RRGGBB colors.', 'Utilisez des couleurs #RRGGBB.', 'Use colores #RRGGBB.'),
    'copyName': ('{name} copy', '{name} copie', '{name} copia'),
}
LOCALES = ('en', 'fr', 'es')


def register(db):
    for key, translations in VALUES.items():
        resource = 'themeCenter.options.' + key
        db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'themeCenterOptions','Theme editor option label','theme_center',1)", (resource,))
        rid = db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?', (resource,)).fetchone()[0]
        for locale, text in zip(LOCALES, translations):
            lid = db.execute('SELECT language_id FROM languages WHERE language_code=?', (locale,)).fetchone()[0]
            # Preserve any later reviewed translation when rerunning this migration.
            if not db.execute('SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?', (rid, lid)).fetchone():
                db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES(?,?,?,0,0,'theme-options-v1')", (rid, lid, text))
    db.commit()


def export(db):
    catalogs = {}
    for locale in LOCALES:
        catalogs[locale] = dict(db.execute("SELECT substr(r.resource_key,21),v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_group='themeCenterOptions' AND r.active=1 AND l.language_code=? ORDER BY r.resource_key", (locale,)))
        if set(catalogs[locale]) != set(VALUES) or any(not v.strip() for v in catalogs[locale].values()):
            raise ValueError(f'{locale}: missing or empty Theme Center options')
        if '{name}' not in catalogs[locale]['copyName']:
            raise ValueError(f'{locale}: missing name parameter')
    lines = ['// Generated from governance resources by scripts/register-theme-center-options.py.',
             'const themeCenterOptions = <String, Map<String, String>>{']
    for locale, entries in catalogs.items():
        lines.append(f'  "{locale}": {{')
        for key, value in entries.items():
            lines.append(f'    {json.dumps(key)}: {json.dumps(value, ensure_ascii=False).replace(chr(36), chr(92)+chr(36))},')
        lines.append('  },')
    return '\n'.join(lines + ['};', ''])


def check_pinned_catalog():
    # CI validates the adopted production-pinned export without a SQLite writer.
    spec=importlib.util.spec_from_file_location('theme_option_catalog',ROOT/'tools/governance-production/theme_option_catalog.py')
    module=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    module.ROOT=ROOT
    pin=json.loads((ROOT/'tools/governance-production/production-pin.json').read_text())
    content=module.render_dart(module.load_catalog(pin))
    if TARGET.read_text()!=content:
        raise ValueError('Theme Center option catalog drift')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    if not args.check:
        parser.error('Use the pinned production registration workflow; the legacy SQLite writer is retired.')
    check_pinned_catalog()
    print('Theme Center options: pinned export validated; no database writes or new readback claimed')
