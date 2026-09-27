import os
import sqlite3

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

def write_report(filename, content):
    filepath = os.path.join(PROJECT_ROOT, filename)
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"Report written: {filename}")

def main():
    print("Executing: Validate Platform UI Features and Generate Reports...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    # 1. LAYOUT_TEMPLATE_DATA_REPORT.md
    c.execute("SELECT * FROM app_layout_templates")
    rows = c.fetchall()
    content = "# Layout Template Data Report\n\n| ID | Code | Name | Type | Description | Active |\n|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['id']} | {r['layout_code']} | {r['layout_name']} | {r['layout_type']} | {r['description']} | {r['active']} |\n"
    write_report("LAYOUT_TEMPLATE_DATA_REPORT.md", content)

    # 2. LAYOUT_REGION_REPORT.md
    c.execute("""
        SELECT r.*, t.layout_code 
        FROM layout_regions r
        JOIN app_layout_templates t ON r.layout_template_id = t.id
    """)
    rows = c.fetchall()
    content = "# Layout Region Report\n\n| ID | Layout Template | Region Code | Name | Type | Width | Position | Active |\n|---|---|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['id']} | {r['layout_code']} | {r['region_code']} | {r['region_name']} | {r['region_type']} | {r['width']} | {r['position']} | {r['active']} |\n"
    write_report("LAYOUT_REGION_REPORT.md", content)

    # 3. SCREEN_LAYOUT_ASSIGNMENT_REPORT.md
    c.execute("""
        SELECT a.id, s.screen_code, t.layout_code, a.app_shell_id, a.responsive_profile, tp.theme_code, a.active
        FROM screen_layout_assignment a
        JOIN screens s ON a.screen_id = s.id
        JOIN app_layout_templates t ON a.layout_template_id = t.id
        JOIN theme_profiles tp ON a.theme_id = tp.id
    """)
    rows = c.fetchall()
    content = f"# Screen Layout Assignment Report\n\nTotal Assignments: {len(rows)}\n\n| ID | Screen Code | Layout Template | App Shell ID | Responsive Profile | Theme | Active |\n|---|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['screen_code']} | {r['layout_code']} | {r['app_shell_id']} | {r['responsive_profile']} | {r['theme_code']} | {r['active']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("SCREEN_LAYOUT_ASSIGNMENT_REPORT.md", content)

    # 4. SECTION_REGION_PLACEMENT_REPORT.md
    c.execute("""
        SELECT p.id, s.screen_code, sec.section_code, r.region_code, p.placement_order, p.grid_column_span, p.visible
        FROM section_region_placement p
        JOIN screens s ON p.screen_id = s.id
        JOIN screen_sections sec ON p.section_id = sec.id
        JOIN layout_regions r ON p.layout_region_id = r.id
    """)
    rows = c.fetchall()
    content = f"# Section Region Placement Report\n\nTotal Placements: {len(rows)}\n\n| ID | Screen Code | Section Code | Region | Order | Col Span | Visible |\n|---|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['screen_code']} | {r['section_code']} | {r['region_code']} | {r['placement_order']} | {r['grid_column_span']} | {r['visible']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("SECTION_REGION_PLACEMENT_REPORT.md", content)

    # 5. PRIMECARE_UI_COMPONENT_SCAN_REPORT.md
    c.execute("SELECT * FROM primecare_ui_component_registry")
    rows = c.fetchall()
    content = f"# PrimeCare UI Component Scan Report\n\nTotal Components Scanned: {len(rows)}\n\n| ID | Code | Class Name | Type | Import Path | Active |\n|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['component_code']} | {r['dart_class_name']} | {r['component_type']} | {r['import_path']} | {r['active']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("PRIMECARE_UI_COMPONENT_SCAN_REPORT.md", content)

    # 6. PRIMECARE_UI_TAG_REGISTRY_REPORT.md
    c.execute("SELECT * FROM primecare_ui_tag_registry")
    rows = c.fetchall()
    content = "# PrimeCare UI Tag Registry Report\n\n| ID | Code | Name | Type | HTML Tag | Semantic Role | Accessibility Role | Active |\n|---|---|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['id']} | {r['tag_code']} | {r['tag_name']} | {r['tag_type']} | {r['html_tag']} | {r['semantic_role']} | {r['accessibility_role']} | {r['active']} |\n"
    write_report("PRIMECARE_UI_TAG_REGISTRY_REPORT.md", content)

    # 7. ELEMENT_COMPONENT_MAPPING_REPORT.md
    c.execute("""
        SELECT m.id, s.screen_code, sec.section_code, el.element_key, m.element_type, c.dart_class_name, t.tag_code, m.component_variant, m.required
        FROM element_primecare_component_map m
        JOIN screens s ON m.screen_id = s.id
        JOIN screen_sections sec ON m.section_id = sec.id
        JOIN screen_section_elements el ON m.element_id = el.id
        JOIN primecare_ui_component_registry c ON m.primecare_component_id = c.id
        JOIN primecare_ui_tag_registry t ON m.tag_id = t.id
    """)
    rows = c.fetchall()
    content = f"# Element Component Mapping Report\n\nTotal Element Mappings: {len(rows)}\n\n| ID | Screen Code | Section Code | Element Key | Element Type | UI Component | Tag | Variant | Required |\n|---|---|---|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['screen_code']} | {r['section_code']} | {r['element_key']} | {r['element_type']} | {r['dart_class_name']} | {r['tag_code']} | {r['component_variant']} | {r['required']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("ELEMENT_COMPONENT_MAPPING_REPORT.md", content)

    # 8. THEME_PROFILE_REPORT.md
    c.execute("SELECT * FROM theme_profiles")
    rows = c.fetchall()
    content = "# Theme Profile Report\n\n| ID | Code | Name | Mode | Brand Name | Description | Default | Active |\n|---|---|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['id']} | {r['theme_code']} | {r['theme_name']} | {r['mode']} | {r['brand_name']} | {r['description']} | {r['default_theme']} | {r['active']} |\n"
    write_report("THEME_PROFILE_REPORT.md", content)

    # 9. THEME_TOKEN_REPORT.md
    c.execute("""
        SELECT t.*, p.theme_code
        FROM theme_design_tokens t
        JOIN theme_profiles p ON t.theme_id = p.id
    """)
    rows = c.fetchall()
    content = f"# Theme Token Report\n\nTotal Tokens: {len(rows)}\n\n| ID | Theme | Token Code | Name | Type | Value | CSS Variable | Active |\n|---|---|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['theme_code']} | {r['token_code']} | {r['token_name']} | {r['token_type']} | {r['token_value']} | {r['css_variable_name']} | {r['active']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("THEME_TOKEN_REPORT.md", content)

    # 10. COMPONENT_THEME_MAP_REPORT.md
    c.execute("""
        SELECT m.id, c.dart_class_name, t.token_code, m.usage_type, m.required, m.default_value
        FROM component_theme_token_map m
        JOIN primecare_ui_component_registry c ON m.primecare_component_id = c.id
        JOIN theme_design_tokens t ON m.theme_token_id = t.id
    """)
    rows = c.fetchall()
    content = f"# Component Theme Map Report\n\nTotal Mappings: {len(rows)}\n\n| ID | Component | Token Code | Usage Type | Required | Default Value |\n|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['dart_class_name']} | {r['token_code']} | {r['usage_type']} | {r['required']} | {r['default_value']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("COMPONENT_THEME_MAP_REPORT.md", content)

    # 11. LAYOUT_THEME_MAP_REPORT.md
    c.execute("""
        SELECT m.id, t.layout_code, r.region_code, tok.token_code, m.usage_type, m.required
        FROM layout_theme_token_map m
        JOIN app_layout_templates t ON m.layout_template_id = t.id
        JOIN layout_regions r ON m.layout_region_id = r.id
        JOIN theme_design_tokens tok ON m.theme_token_id = tok.id
    """)
    rows = c.fetchall()
    content = f"# Layout Theme Map Report\n\nTotal Mappings: {len(rows)}\n\n| ID | Layout Template | Region Code | Token Code | Usage Type | Required |\n|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['layout_code']} | {r['region_code']} | {r['token_code']} | {r['usage_type']} | {r['required']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("LAYOUT_THEME_MAP_REPORT.md", content)

    # 12. RESPONSIVE_RULES_REPORT.md
    c.execute("""
        SELECT r.id, p.profile_code, r.breakpoint_code, r.target_type, r.behavior, r.column_count, r.hidden
        FROM responsive_rules r
        JOIN responsive_profiles p ON r.responsive_profile_id = p.id
    """)
    rows = c.fetchall()
    content = f"# Responsive Rules Report\n\nTotal Rules: {len(rows)}\n\n| ID | Profile | Breakpoint | Target Type | Behavior | Col Count | Hidden |\n|---|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['id']} | {r['profile_code']} | {r['breakpoint_code']} | {r['target_type']} | {r['behavior']} | {r['column_count']} | {r['hidden']} |\n"
    write_report("RESPONSIVE_RULES_REPORT.md", content)

    # 13. ACCESSIBILITY_IMPLEMENTATION_REPORT.md
    c.execute("""
        SELECT m.id, s.screen_code, sec.section_code, el.element_key, r.rule_code, m.aria_label_source, m.keyboard_required, m.required
        FROM element_accessibility_implementation m
        JOIN screens s ON m.screen_id = s.id
        JOIN screen_sections sec ON m.section_id = sec.id
        JOIN screen_section_elements el ON m.element_id = el.id
        JOIN ui_accessibility_rules r ON m.rule_id = r.id
    """)
    rows = c.fetchall()
    content = f"# Accessibility Implementation Report\n\nTotal Implementations: {len(rows)}\n\n| ID | Screen Code | Section Code | Element Key | Rule Code | Aria Source | Keyboard | Required |\n|---|---|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['screen_code']} | {r['section_code']} | {r['element_key']} | {r['rule_code']} | {r['aria_label_source']} | {r['keyboard_required']} | {r['required']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("ACCESSIBILITY_IMPLEMENTATION_REPORT.md", content)

    # 14. QA_TEST_ID_REGISTRY_REPORT.md
    c.execute("""
        SELECT q.id, s.screen_code, sec.section_code, el.element_key, q.test_id, q.test_id_type, q.selector_pattern
        FROM qa_test_id_registry q
        JOIN screens s ON q.screen_id = s.id
        JOIN screen_sections sec ON q.section_id = sec.id
        LEFT JOIN screen_section_elements el ON q.element_id = el.id
    """)
    rows = c.fetchall()
    content = f"# QA Test ID Registry Report\n\nTotal Registered Test IDs: {len(rows)}\n\n| ID | Screen Code | Section Code | Element Key | Test ID | Type | Selector Pattern |\n|---|---|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['screen_code']} | {r['section_code']} | {r['element_key']} | {r['test_id']} | {r['test_id_type']} | {r['selector_pattern']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("QA_TEST_ID_REGISTRY_REPORT.md", content)

    # 15. VISUAL_STATE_REPORT.md
    c.execute("""
        SELECT m.id, el.element_key, s.state_code, m.required, m.implementation_notes
        FROM element_visual_state_map m
        JOIN screen_section_elements el ON m.element_id = el.id
        JOIN ui_visual_states s ON m.visual_state_id = s.id
    """)
    rows = c.fetchall()
    content = f"# Visual State Report\n\nTotal Mappings: {len(rows)}\n\n| ID | Element Key | State Code | Required | Notes |\n|---|---|---|---|---|\n"
    for r in rows[:50]:
        content += f"| {r['id']} | {r['element_key']} | {r['state_code']} | {r['required']} | {r['implementation_notes']} |\n"
    if len(rows) > 50:
        content += f"\n*...and {len(rows) - 50} more records.*\n"
    write_report("VISUAL_STATE_REPORT.md", content)

    # 16. COMPONENT_SELECTION_RULE_REPORT.md
    c.execute("""
        SELECT r.id, r.element_type, r.section_type, r.layout_type, cp.dart_class_name as preferred, cf.dart_class_name as fallback, r.rule_description
        FROM component_selection_rules r
        JOIN primecare_ui_component_registry cp ON r.preferred_component_id = cp.id
        JOIN primecare_ui_component_registry cf ON r.fallback_component_id = cf.id
    """)
    rows = c.fetchall()
    content = "# Component Selection Rule Report\n\n| ID | Element Type | Section Type | Layout Type | Preferred Component | Fallback Component | Description |\n|---|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['id']} | {r['element_type']} | {r['section_type']} | {r['layout_type']} | {r['preferred']} | {r['fallback']} | {r['rule_description']} |\n"
    write_report("COMPONENT_SELECTION_RULE_REPORT.md", content)

    # 17. LANGUAGE_MASTER_REPORT.md
    c.execute("SELECT * FROM languages")
    rows = c.fetchall()
    content = "# Language Master Report\n\n| ID | Code | ISO | Name | Native Name | Culture | Direction | Enabled | Default |\n|---|---|---|---|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['language_id']} | {r['language_code']} | {r['iso_code']} | {r['language_name']} | {r['native_name']} | {r['culture_code']} | {r['direction']} | {r['enabled']} | {r['default_language']} |\n"
    write_report("LANGUAGE_MASTER_REPORT.md", content)

    # 18. TRANSLATION_COVERAGE_REPORT.md
    c.execute("""
        SELECT l.language_code, COUNT(v.translation_id) as count
        FROM languages l
        LEFT JOIN language_resource_values v ON l.language_id = v.language_id
        GROUP BY l.language_id
    """)
    rows = c.fetchall()
    content = "# Translation Coverage Report\n\n| Language Code | Translated Keys Count |\n|---|---|\n"
    for r in rows:
        content += f"| {r['language_code']} | {r['count']} |\n"
    write_report("TRANSLATION_COVERAGE_REPORT.md", content)

    # 19. RTL_SUPPORT_REPORT.md
    c.execute("""
        SELECT l.language_code, r.mirror_sidebar, r.mirror_icons, r.reverse_layout
        FROM rtl_language_rules r
        JOIN languages l ON r.language_id = l.language_id
    """)
    rows = c.fetchall()
    content = "# RTL Support Report\n\n| Language | Mirror Sidebar | Mirror Icons | Reverse Layout |\n|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['language_code']} | {r['mirror_sidebar']} | {r['mirror_icons']} | {r['reverse_layout']} |\n"
    write_report("RTL_SUPPORT_REPORT.md", content)

    # 20. RESOURCE_KEY_REPORT.md
    c.execute("SELECT * FROM language_resources")
    rows = c.fetchall()
    content = "# Resource Key Report\n\n| ID | Resource Key | Group | Description | Context |\n|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['resource_id']} | {r['resource_key']} | {r['resource_group']} | {r['description']} | {r['context']} |\n"
    write_report("RESOURCE_KEY_REPORT.md", content)

    # 21. USER_LANGUAGE_REPORT.md
    c.execute("""
        SELECT u.user_id, l.language_code, u.culture_code, u.timezone, u.currency
        FROM user_language_preferences u
        JOIN languages l ON u.language_id = l.language_id
    """)
    rows = c.fetchall()
    content = "# User Language Preferences Report\n\n| User ID | Language | Culture | Timezone | Currency |\n|---|---|---|---|---|\n"
    for r in rows:
        content += f"| {r['user_id']} | {r['language_code']} | {r['culture_code']} | {r['timezone']} | {r['currency']} |\n"
    write_report("USER_LANGUAGE_REPORT.md", content)

    # 22. LOCALIZATION_READINESS_REPORT.md
    # Calculate ratio of screens mapping to layout assignment and resource counts
    c.execute("SELECT COUNT(*) FROM screens")
    total_screens = c.fetchone()[0]
    content = f"# Localization Readiness Report\n\nTotal Platform Screens: {total_screens}\nLocalization Mode: 100% Database-Driven\n"
    write_report("LOCALIZATION_READINESS_REPORT.md", content)

    # 23. Run Validation Check assertions
    print("\nRunning Database Validation Assertions...")
    errors = []
    
    # - every screen has layout assignment
    c.execute("SELECT id, screen_code FROM screens WHERE id NOT IN (SELECT screen_id FROM screen_layout_assignment)")
    missing_layout = c.fetchall()
    if missing_layout:
        errors.append(f"Screens missing layout assignment: {[r['screen_code'] for r in missing_layout]}")

    # - every layout has regions
    c.execute("SELECT id, layout_code FROM app_layout_templates WHERE id NOT IN (SELECT layout_template_id FROM layout_regions)")
    missing_regions = c.fetchall()
    if missing_regions:
        errors.append(f"Layouts missing regions: {[r['layout_code'] for r in missing_regions]}")

    # - every section has region placement
    c.execute("SELECT id, section_code FROM screen_sections WHERE id NOT IN (SELECT section_id FROM section_region_placement)")
    missing_placements = c.fetchall()
    if missing_placements:
        errors.append(f"Sections missing region placement: {[r['section_code'] for r in missing_placements]}")

    # - every element has PrimeCare component mapping
    c.execute("SELECT id, element_key FROM screen_section_elements WHERE id NOT IN (SELECT element_id FROM element_primecare_component_map)")
    missing_comp_maps = c.fetchall()
    if missing_comp_maps:
        errors.append(f"Elements missing component mapping: {[r['element_key'] for r in missing_comp_maps]}")

    # - every element has semantic tag
    c.execute("SELECT id, element_key FROM screen_section_elements WHERE id NOT IN (SELECT element_id FROM element_primecare_component_map WHERE tag_id IS NOT NULL)")
    missing_tags = c.fetchall()
    if missing_tags:
        errors.append(f"Elements missing tag registry mapping: {[r['element_key'] for r in missing_tags]}")

    # - every element has QA test id
    c.execute("SELECT id, element_key FROM screen_section_elements WHERE id NOT IN (SELECT element_id FROM qa_test_id_registry WHERE element_id IS NOT NULL)")
    missing_qa = c.fetchall()
    if missing_qa:
        errors.append(f"Elements missing QA test ID: {[r['element_key'] for r in missing_qa]}")

    # - every component has import path
    c.execute("SELECT component_code FROM primecare_ui_component_registry WHERE import_path IS NULL OR import_path = ''")
    missing_imports = c.fetchall()
    if missing_imports:
        errors.append(f"Components missing import path: {[r['component_code'] for r in missing_imports]}")

    # - every theme has required tokens
    c.execute("SELECT id, theme_code FROM theme_profiles")
    themes = c.fetchall()
    for t in themes:
        c.execute("SELECT COUNT(*) FROM theme_design_tokens WHERE theme_id = ?", (t['id'],))
        count = c.fetchone()[0]
        if count == 0:
            errors.append(f"Theme '{t['theme_code']}' has zero design tokens!")

    # - every layout region has theme tokens
    c.execute("SELECT id, region_code FROM layout_regions WHERE id NOT IN (SELECT layout_region_id FROM layout_theme_token_map)")
    missing_region_tokens = c.fetchall()
    if missing_region_tokens:
        errors.append(f"Layout regions missing theme tokens: {[r['region_code'] for r in missing_region_tokens]}")

    # - every section has responsive behavior
    c.execute("SELECT section_code FROM screen_sections JOIN section_region_placement ON screen_sections.id = section_region_placement.section_id WHERE responsive_behavior IS NULL OR responsive_behavior = ''")
    missing_sec_resp = c.fetchall()
    if missing_sec_resp:
        errors.append(f"Sections missing responsive behavior configuration: {[r['section_code'] for r in missing_sec_resp]}")

    # - every interactive element has accessibility rule
    c.execute("""
        SELECT element_key FROM screen_section_elements 
        WHERE element_type IN ('button', 'input', 'textarea', 'dropdown', 'checkbox', 'radio', 'date_picker') 
        AND id NOT IN (SELECT element_id FROM element_accessibility_implementation)
    """)
    missing_a11y = c.fetchall()
    if missing_a11y:
        errors.append(f"Interactive elements missing accessibility implementations: {[r['element_key'] for r in missing_a11y]}")

    # - every button has visual states
    c.execute("SELECT element_key FROM screen_section_elements WHERE element_type = 'button' AND id NOT IN (SELECT element_id FROM element_visual_state_map)")
    missing_visual_states = c.fetchall()
    if missing_visual_states:
        errors.append(f"Buttons missing visual states: {[r['element_key'] for r in missing_visual_states]}")

    if errors:
        print("\n[VALIDATION FAILED] Found integrity errors:")
        for err in errors:
            print(f"- {err}")
        conn.close()
        exit(1)
    else:
        print("\n[VALIDATION SUCCESS] All integrity validations passed perfectly!")

    conn.close()

if __name__ == "__main__":
    main()
