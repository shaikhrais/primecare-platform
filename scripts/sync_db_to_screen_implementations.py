import os
import sqlite3
import json
import sys

sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))
from report_handler import ReportHandler

def sync_db_to_screens():
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    db_path = os.path.join(project_root, '.agents', 'governance', 'governance.db')
    
    print(f"[DB Sync] Reading screen statuses from SQLite DB: {db_path}")
    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    query = """
        SELECT 
            s.id,
            s.screen_code,
            s.screen_name,
            s.route_path,
            s.actual_file_path,
            s.completeness_score,
            s.implementation_tag,
            s.content_tag,
            s.api_tag,
            s.test_tag,
            s.review_tag,
            s.screenshot_path,
            s.runtime_verified,
            s.cypress_verified,
            s.production_ready,
            a.app_code,
            a.app_name,
            r.role_code,
            r.role_name,
            req.business_purpose,
            req.user_story
        FROM screens s
        LEFT JOIN apps a ON s.app_id = a.id
        LEFT JOIN roles r ON s.role_id = r.id
        LEFT JOIN screen_requirements req ON s.id = req.screen_id
        WHERE s.active = 1
        ORDER BY s.screen_code
    """
    cursor.execute(query)
    screens = [dict(r) for r in cursor.fetchall()]

    print(f"[DB Sync] Loaded {len(screens)} screens from governance.db.")

    # 1. Generate JSON Manifest
    manifest_path = os.path.join(project_root, 'docs', 'gallery', 'screen_status_manifest.json')
    os.makedirs(os.path.dirname(manifest_path), exist_ok=True)
    with open(manifest_path, 'w', encoding='utf-8') as f:
        json.dump(screens, f, indent=2)
    print(f"[DB Sync] Exported screen status manifest to {manifest_path}")

    # 2. Generate Dart Screen Status Registry
    dart_path = os.path.join(project_root, 'packages', 'flutter_core', 'lib', 'registry', 'db_screen_status_registry.dart')
    os.makedirs(os.path.dirname(dart_path), exist_ok=True)

    dart_lines = [
        "// Generated from SQLite DB (.agents/governance/governance.db) - Single Source of Truth",
        "class DbScreenStatusRegistry {",
        "  static const Map<String, Map<String, dynamic>> screens = {"
    ]

    for s in screens:
        code = s['screen_code']
        score = s['completeness_score'] or 0
        tag = s['implementation_tag'] or 'placeholder'
        api = s['api_tag'] or 'api_missing'
        test = s['test_tag'] or 'no_test'
        review = s['review_tag'] or 'not_reviewed'
        ready = 'true' if s['production_ready'] == 1 else 'false'
        route = s['route_path'] or '/'
        app = s['app_code'] or 'general'
        role = s['role_code'] or 'all'

        dart_lines.append(f"    '{code}': {{")
        dart_lines.append(f"      'screenCode': '{code}',")
        dart_lines.append(f"      'completenessScore': {score},")
        dart_lines.append(f"      'implementationTag': '{tag}',")
        dart_lines.append(f"      'apiTag': '{api}',")
        dart_lines.append(f"      'testTag': '{test}',")
        dart_lines.append(f"      'reviewTag': '{review}',")
        dart_lines.append(f"      'productionReady': {ready},")
        dart_lines.append(f"      'routePath': '{route}',")
        dart_lines.append(f"      'appCode': '{app}',")
        dart_lines.append(f"      'roleCode': '{role}',")
        dart_lines.append("    },")

    dart_lines.append("  };")
    dart_lines.append("}")
    
    with open(dart_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(dart_lines))
    print(f"[DB Sync] Exported Dart status registry to {dart_path}")

    # 3. Update Report Gallery
    handler = ReportHandler(db_path=db_path)
    handler.generate_report()

    conn.close()
    print("[DB Sync] Successfully synchronized SQLite screen status!")

if __name__ == '__main__':
    sync_db_to_screens()
