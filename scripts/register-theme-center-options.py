"""Register Theme Center option resources and export a shared Dart catalog."""
import argparse
import json
from pathlib import Path
import sqlite3

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


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    with sqlite3.connect('file:' + str(ROOT / '.agents/governance/governance.db') + '?mode=ro', uri=True) as source:
        db = sqlite3.connect(':memory:') if args.check else sqlite3.connect(ROOT / '.agents/governance/governance.db')
        if args.check:
            source.backup(db)
        try:
            register(db)
            content = export(db)
            if args.check:
                if TARGET.read_text() != content:
                    raise SystemExit('Theme Center option catalog drift')
            else:
                TARGET.write_text(content)
        finally:
            db.close()
    print('Theme Center options: 15 keys validated in en/fr/es')
