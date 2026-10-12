"""Register Reality Check filter text in governance and export its runtime catalog."""
import argparse
import json
from pathlib import Path
import sqlite3
import re

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / 'packages/primecare_ui/lib/src/localization/admin_reality_filter_catalog.dart'
SOURCE = ROOT / 'packages/primecare_ui/lib/src/localization/screens/admin_reality_check.json'


def load_document(path):
    document = json.loads(path.read_text())
    if set(document) != {'version', 'screen', 'locales'} or document['version'] != 1 or document['screen'] != 'admin_reality_check':
        raise ValueError('Invalid screen text document')
    locales = document['locales']
    if set(locales) != {'en', 'fr', 'es'}:
        raise ValueError('Screen text requires en/fr/es')
    english = locales['en']
    if not isinstance(english, dict) or not english:
        raise ValueError('Missing screen text')
    for locale, entries in locales.items():
        if not isinstance(entries, dict) or set(entries) != set(english):
            raise ValueError(f'{locale}: keys differ')
        for key, text in entries.items():
            if not isinstance(text, str) or not text.strip() or len(text) > 2000:
                raise ValueError(f'{locale}.{key}: invalid text')
            if set(re.findall(r'\{([A-Za-z]+)\}', text)) != set(re.findall(r'\{([A-Za-z]+)\}', english[key])):
                raise ValueError(f'{locale}.{key}: parameters differ')
    return document


DOCUMENT = load_document(SOURCE)
VALUES = {key: tuple(DOCUMENT['locales'][locale][key] for locale in ('en', 'fr', 'es'))
          for key in DOCUMENT['locales']['en']}



def register(db, overwrite=False):
    for key, translations in VALUES.items():
        resource = 'adminRealityFilter.' + key
        db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'adminRealityFilter','Reality Check search and filter text','admin_reality_check',1)", (resource,))
        rid = db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?', (resource,)).fetchone()[0]
        for locale, text in zip(('en', 'fr', 'es'), translations):
            lid = db.execute('SELECT language_id FROM languages WHERE language_code=?', (locale,)).fetchone()[0]
            if overwrite:
                db.execute("UPDATE language_resource_values SET translated_text=?,reviewed=0,approved=0,version='screen-json-v1' WHERE resource_id=? AND language_id=? AND translated_text<>?", (text, rid, lid, text))
            if not db.execute('SELECT 1 FROM language_resource_values WHERE resource_id=? AND language_id=?', (rid, lid)).fetchone():
                db.execute("INSERT INTO language_resource_values(resource_id,language_id,translated_text,reviewed,approved,version) VALUES(?,?,?,0,0,'reality-filters-v1')", (rid, lid, text))
    db.commit()


def export(db):
    lines = ['// Generated from governance by scripts/register-admin-reality-filters.py.',
             'const adminRealityFilterCatalog = <String, Map<String, String>>{']
    for locale in ('en', 'fr', 'es'):
        rows = dict(db.execute("SELECT substr(r.resource_key,20),v.translated_text FROM language_resources r JOIN language_resource_values v USING(resource_id) JOIN languages l USING(language_id) WHERE r.resource_group='adminRealityFilter' AND r.active=1 AND l.language_code=? ORDER BY r.resource_key", (locale,)))
        if set(rows) != set(VALUES) or any(not text.strip() for text in rows.values()):
            raise ValueError(f'{locale}: incomplete Reality Check filter catalog')
        for key, value in rows.items():
            if set(re.findall(r'\{([A-Za-z]+)\}', value)) != set(re.findall(r'\{([A-Za-z]+)\}', VALUES[key][0])):
                raise ValueError(f'{locale}.{key}: interpolation parameters differ')
        lines.append(f'  "{locale}": {{')
        for key, value in rows.items():
            encoded = json.dumps(value, ensure_ascii=False).replace('$', r'\$')
            lines.append(f'    {json.dumps(key)}: {encoded},')
        lines.append('  },')
    return '\n'.join(lines + ['};', ''])


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--import-json', type=Path, help='Apply a complete screen JSON document to governance')
    args = parser.parse_args()
    if args.check and args.import_json:
        parser.error('--check and --import-json are mutually exclusive')
    if args.import_json:
        document = load_document(args.import_json)
        if set(document['locales']['en']) != set(VALUES):
            raise ValueError('Import must preserve existing screen resource keys')
        VALUES = {key: tuple(document['locales'][locale][key] for locale in ('en', 'fr', 'es')) for key in VALUES}
    with sqlite3.connect('file:' + str(ROOT / '.agents/governance/governance.db') + '?mode=ro', uri=True) as source:
        db = sqlite3.connect(':memory:') if args.check else sqlite3.connect(ROOT / '.agents/governance/governance.db')
        if args.check:
            source.backup(db)
        try:
            register(db, overwrite=bool(args.import_json))
            content = export(db)
            if args.check:
                if TARGET.read_text() != content:
                    raise SystemExit('Reality Check filter catalog drift')
            else:
                TARGET.write_text(content)
                if args.import_json:
                    SOURCE.write_text(json.dumps(document, ensure_ascii=False, indent=2) + '\n')
        finally:
            db.close()
    print('Reality Check filters: 35 keys validated in en/fr/es')
