"""Register Reality Check filter text in governance and export its runtime catalog."""
import argparse
import json
from pathlib import Path
import sqlite3

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / 'packages/primecare_ui/lib/src/localization/admin_reality_filter_catalog.dart'
VALUES = {
    'search': ('Search route, name, or purpose...', 'Rechercher un parcours, un nom ou un objectif...', 'Buscar ruta, nombre o propósito...'),
    'reload': ('Reload database check metrics', 'Actualiser les indicateurs de vérification', 'Actualizar métricas de verificación'),
    'All': ('All screens', 'Tous les écrans', 'Todas las pantallas'),
    'Zero Interaction': ('Zero interaction', 'Aucune interaction', 'Sin interacción'),
    'Low Interaction': ('Low interaction', 'Faible interaction', 'Poca interacción'),
    'Unclear Purpose': ('Unclear purpose', 'Objectif peu clair', 'Propósito poco claro'),
    'No User Value': ('No user value', 'Sans valeur pour l’utilisateur', 'Sin valor para el usuario'),
    'False Progress': ('False progress', 'Fausse progression', 'Progreso falso'),
}


def register(db):
    for key, translations in VALUES.items():
        resource = 'adminRealityFilter.' + key
        db.execute("INSERT OR IGNORE INTO language_resources(resource_key,resource_group,description,context,active) VALUES(?,'adminRealityFilter','Reality Check search and filter text','admin_reality_check',1)", (resource,))
        rid = db.execute('SELECT resource_id FROM language_resources WHERE resource_key=?', (resource,)).fetchone()[0]
        for locale, text in zip(('en', 'fr', 'es'), translations):
            lid = db.execute('SELECT language_id FROM languages WHERE language_code=?', (locale,)).fetchone()[0]
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
        lines.append(f'  "{locale}": {{')
        for key, value in rows.items():
            encoded = json.dumps(value, ensure_ascii=False).replace('$', r'\$')
            lines.append(f'    {json.dumps(key)}: {encoded},')
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
                    raise SystemExit('Reality Check filter catalog drift')
            else:
                TARGET.write_text(content)
        finally:
            db.close()
    print('Reality Check filters: 8 keys validated in en/fr/es')
