#!/usr/bin/env python3
"""Register approved auth presentation and generate localizable design assets."""
import json, sqlite3, re
from pathlib import Path
root = Path(__file__).resolve().parents[1]
spec = json.loads((root / 'design/auth-experience.json').read_text())
db = sqlite3.connect(root / '.agents/governance/governance.db')
with db:
    for component in spec['components']:
        db.execute("""INSERT INTO primecare_ui_component_registry
            (component_code, component_name, component_type, dart_class_name,
             source_file_path, purpose, active)
            VALUES (?, ?, 'auth', ?, ?, 'Shared accessible authentication presentation', 1)
            ON CONFLICT(component_code) DO UPDATE SET active=1""",
            (component, component, component,
             'packages/primecare_ui/lib/src/features/auth/auth_experience.dart'))
    theme_id = db.execute("SELECT id FROM theme_profiles WHERE theme_code='light'").fetchone()[0]
    for key, value in spec['tokens'].items():
        code = 'auth.' + key
        db.execute("DELETE FROM theme_design_tokens WHERE theme_id=? AND token_code=?", (theme_id, code))
        db.execute("""INSERT INTO theme_design_tokens
            (theme_id, token_code, token_name, token_type, token_value, dart_token_name, active)
            VALUES (?, ?, ?, 'dimension', ?, ?, 1)""", (theme_id, code, key, str(value), key))
    resources = {}
    for language_code, copy in {'en': spec['copy'], **spec.get('translations', {})}.items():
        language_id = db.execute("SELECT language_id FROM languages WHERE language_code=?", (language_code,)).fetchone()[0]
        for key, value in copy.items():
            resource = 'auth_design_' + key
            db.execute("""INSERT INTO language_resources
                (resource_key, resource_group, description, context, active)
                VALUES (?, 'auth_design', 'Shared authentication presentation', 'auth', 1)
                ON CONFLICT(resource_key) DO UPDATE SET active=1""", (resource,))
            resource_id = db.execute("SELECT resource_id FROM language_resources WHERE resource_key=?", (resource,)).fetchone()[0]
            db.execute("DELETE FROM language_resource_values WHERE resource_id=? AND language_id=?", (resource_id, language_id))
            db.execute("""INSERT INTO language_resource_values
                (resource_id, language_id, translated_text, reviewed, approved, version)
                VALUES (?, ?, ?, 0, 0, 'auth-design-v1')""", (resource_id, language_id, value))
        resources[language_code] = dict(db.execute("""SELECT r.resource_key, v.translated_text
            FROM language_resources r JOIN language_resource_values v USING(resource_id)
            WHERE r.resource_group='auth_design' AND v.language_id=?""", (language_id,)))
    dimensions = list(db.execute("""SELECT dart_token_name, token_value FROM theme_design_tokens
        WHERE theme_id=? AND token_code LIKE 'auth.%' ORDER BY dart_token_name""", (theme_id,)))
for path in (root / 'apps').glob('*/assets/translations/*.json'):
    if path.stem not in resources:
        continue
    original = path.read_text()
    match = re.search(r'\n( +)"', original)
    indent = len(match.group(1)) if match else 2
    data = json.loads(original)
    data.update(resources[path.stem])
    path.write_text(json.dumps(data, ensure_ascii=False, indent=indent) + '\n')
target = root / 'packages/primecare_ui/lib/src/features/auth/auth_design_tokens.dart'
target.parent.mkdir(parents=True, exist_ok=True)
target.write_text('// Generated from governance.db by apply-auth-design.py.\n'
    + 'class AuthDesignTokens {\n'
    + ''.join('  static const double ' + key + ' = ' + value + ';\n' for key, value in dimensions)
    + '}\n')
db.close()

