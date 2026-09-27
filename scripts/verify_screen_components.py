import os
import sqlite3
import json
import re
import sys

def verify_screen_components_and_dom():
    project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
    db_path = os.path.join(project_root, '.agents', 'governance', 'governance.db')
    screens_dir = os.path.join(project_root, 'packages', 'primecare_ui', 'lib', 'src', 'features', 'generated_screens')

    print("==================================================")
    print("STARTING DOM & COMPONENT VERIFICATION AUDIT")
    print("==================================================")
    print(f"[Verifier] Reading database requirements from {db_path}...")

    conn = sqlite3.connect(db_path)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()

    cursor.execute("""
        SELECT 
            s.id,
            s.screen_code,
            s.screen_name,
            s.route_path,
            s.screenshot_path,
            a.app_code,
            a.app_name,
            r.role_code,
            r.role_name
        FROM screens s
        LEFT JOIN apps a ON s.app_id = a.id
        LEFT JOIN roles r ON s.role_id = r.id
        WHERE s.active = 1
        ORDER BY s.screen_code
    """)
    screens = [dict(r) for r in cursor.fetchall()]

    total_screens = len(screens)
    fully_verified_screens = 0
    total_sections_checked = 0
    total_sections_found = 0
    total_elements_checked = 0
    total_elements_found = 0
    total_apis_checked = 0
    total_apis_found = 0
    missing_items_report = []

    for s in screens:
        sid = s['id']
        screen_code = s['screen_code']
        screen_name = s['screen_name'] or screen_code
        app_code = s['app_code'] or 'general'
        role_code = s['role_code'] or 'all'
        
        file_name = f"{screen_code}.dart"
        file_path = os.path.join(screens_dir, file_name)
        if not os.path.exists(file_path):
            # Try camel_to_snake
            s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', screen_code)
            file_name = re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower() + '.dart'
            file_path = os.path.join(screens_dir, file_name)

        code_content = ""
        file_exists = os.path.exists(file_path)
        if file_exists:
            with open(file_path, 'r', encoding='utf-8') as f:
                code_content = f.read()

        # 1. Verify Required Sections
        cursor.execute("SELECT section_name FROM screen_sections WHERE screen_id = ?", (sid,))
        sections = [r['section_name'] for r in cursor.fetchall()]
        sec_missing = []
        for sec in sections:
            total_sections_checked += 1
            if sec.lower() in code_content.lower():
                total_sections_found += 1
            else:
                sec_missing.append(sec)

        # 2. Verify Required Elements & Test IDs
        cursor.execute("SELECT label, test_id FROM screen_section_elements WHERE screen_id = ?", (sid,))
        elements = [dict(r) for r in cursor.fetchall()]
        el_missing = []
        for el in elements:
            total_elements_checked += 1
            label = el['label'] or ''
            test_id = el['test_id'] or ''
            if (label and label.lower() in code_content.lower()) or (test_id and test_id.lower() in code_content.lower()):
                total_elements_found += 1
            else:
                el_missing.append(label or test_id)

        # 3. Verify Mapped APIs
        cursor.execute("SELECT a.endpoint_path FROM screen_api_map m JOIN api_registry a ON m.api_id = a.id WHERE m.screen_id = ?", (sid,))
        apis = [r['endpoint_path'] for r in cursor.fetchall()]
        api_missing = []
        for api in apis:
            total_apis_checked += 1
            if api.lower() in code_content.lower():
                total_apis_found += 1
            else:
                api_missing.append(api)

        # 4. Verify Screenshot File
        screenshot_rel = s['screenshot_path'] or f"docs/gallery/screenshots/{app_code}/{role_code}/{screen_code}.png"
        screenshot_full = os.path.join(project_root, screenshot_rel.replace('/', os.sep))
        screenshot_exists = os.path.exists(screenshot_full) and os.path.getsize(screenshot_full) > 0

        is_complete = file_exists and screenshot_exists and len(sec_missing) == 0 and len(el_missing) == 0 and len(api_missing) == 0
        if is_complete:
            fully_verified_screens += 1
        else:
            missing_items_report.append({
                'screen_code': screen_code,
                'screen_name': screen_name,
                'file_exists': file_exists,
                'screenshot_exists': screenshot_exists,
                'missing_sections': sec_missing,
                'missing_elements': el_missing,
                'missing_apis': api_missing,
            })

    # Save summary report JSON
    report_data = {
        'total_screens': total_screens,
        'fully_verified_screens': fully_verified_screens,
        'completeness_percentage': round((fully_verified_screens / total_screens) * 100, 2) if total_screens > 0 else 100,
        'sections_coverage': f"{total_sections_found}/{total_sections_checked} ({round((total_sections_found/max(1, total_sections_checked))*100, 1)}%)",
        'elements_coverage': f"{total_elements_found}/{total_elements_checked} ({round((total_elements_found/max(1, total_elements_checked))*100, 1)}%)",
        'apis_coverage': f"{total_apis_found}/{total_apis_checked} ({round((total_apis_found/max(1, total_apis_checked))*100, 1)}%)",
        'missing_items_count': len(missing_items_report),
        'missing_items_details': missing_items_report[:10], # Top 10 missing items if any
    }

    out_json = os.path.join(project_root, 'docs', 'gallery', 'verification_report.json')
    os.makedirs(os.path.dirname(out_json), exist_ok=True)
    with open(out_json, 'w', encoding='utf-8') as f:
        json.dump(report_data, f, indent=2)

    print("\n==================================================")
    print("DOM & COMPONENT VERIFICATION SUMMARY")
    print("==================================================")
    print(f"• Total Screens Analyzed: {total_screens}")
    print(f"• 100% Fully Verified Screens: {fully_verified_screens} / {total_screens} ({report_data['completeness_percentage']}%)")
    print(f"• Required DB Sections Found: {report_data['sections_coverage']}")
    print(f"• Required DB Elements & Controls Found: {report_data['elements_coverage']}")
    print(f"• Mapped Endpoint APIs Connected: {report_data['apis_coverage']}")
    print(f"• Report saved to: {out_json}")
    print("==================================================")

if __name__ == '__main__':
    verify_screen_components_and_dom()
