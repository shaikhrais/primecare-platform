import os
import re
import sqlite3
import json
from pathlib import Path

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")
PRIMECARE_UI_PATH = os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib")

def main():
    print("Executing: Remodel Governance DB and Populate UI Elements...")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = OFF;")
    c = conn.cursor()

    # 1. Create Tables
    tables_sql = {
        "app_layout_templates": """
            CREATE TABLE IF NOT EXISTS app_layout_templates (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                layout_code TEXT UNIQUE,
                layout_name TEXT,
                layout_type TEXT,
                description TEXT,
                has_sidebar INTEGER,
                has_topbar INTEGER,
                has_breadcrumbs INTEGER,
                has_right_panel INTEGER,
                has_bottom_action_bar INTEGER,
                has_footer INTEGER,
                content_slot_count INTEGER,
                responsive_behavior TEXT,
                default_theme_id INTEGER,
                active INTEGER
            );
        """,
        "layout_regions": """
            CREATE TABLE IF NOT EXISTS layout_regions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                layout_template_id INTEGER,
                region_code TEXT,
                region_name TEXT,
                region_type TEXT,
                display_order INTEGER,
                width TEXT,
                height TEXT,
                position TEXT,
                sticky INTEGER,
                scroll_behavior TEXT,
                responsive_behavior TEXT,
                test_id TEXT,
                active INTEGER,
                FOREIGN KEY(layout_template_id) REFERENCES app_layout_templates(id)
            );
        """,
        "screen_layout_assignment": """
            CREATE TABLE IF NOT EXISTS screen_layout_assignment (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER UNIQUE,
                layout_template_id INTEGER,
                app_shell_id TEXT,
                main_content_region_id INTEGER,
                responsive_profile TEXT,
                theme_id INTEGER,
                active INTEGER,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(layout_template_id) REFERENCES app_layout_templates(id)
            );
        """,
        "section_region_placement": """
            CREATE TABLE IF NOT EXISTS section_region_placement (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                section_id INTEGER UNIQUE,
                layout_region_id INTEGER,
                placement_order INTEGER,
                grid_column_span INTEGER,
                grid_row_span INTEGER,
                width_behavior TEXT,
                sticky INTEGER,
                collapsible INTEGER,
                visible INTEGER,
                responsive_behavior TEXT,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(section_id) REFERENCES screen_sections(id),
                FOREIGN KEY(layout_region_id) REFERENCES layout_regions(id)
            );
        """,
        "primecare_ui_component_registry": """
            CREATE TABLE IF NOT EXISTS primecare_ui_component_registry (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                component_code TEXT UNIQUE,
                component_name TEXT,
                component_type TEXT,
                dart_class_name TEXT,
                html_tag_equivalent TEXT,
                import_path TEXT,
                source_file_path TEXT,
                purpose TEXT,
                allowed_element_types_json TEXT,
                required_props_json TEXT,
                optional_props_json TEXT,
                event_props_json TEXT,
                accessibility_props_json TEXT,
                theme_token_requirements_json TEXT,
                example_usage TEXT,
                active INTEGER
            );
        """,
        "primecare_ui_tag_registry": """
            CREATE TABLE IF NOT EXISTS primecare_ui_tag_registry (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                tag_code TEXT UNIQUE,
                tag_name TEXT,
                tag_type TEXT,
                html_tag TEXT,
                semantic_role TEXT,
                purpose TEXT,
                default_testid_pattern TEXT,
                accessibility_role TEXT,
                active INTEGER
            );
        """,
        "element_primecare_component_map": """
            CREATE TABLE IF NOT EXISTS element_primecare_component_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                section_id INTEGER,
                element_id INTEGER UNIQUE,
                element_type TEXT,
                primecare_component_id INTEGER,
                tag_id INTEGER,
                component_variant TEXT,
                usage_reason TEXT,
                required INTEGER,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(section_id) REFERENCES screen_sections(id),
                FOREIGN KEY(element_id) REFERENCES screen_section_elements(id),
                FOREIGN KEY(primecare_component_id) REFERENCES primecare_ui_component_registry(id),
                FOREIGN KEY(tag_id) REFERENCES primecare_ui_tag_registry(id)
            );
        """,
        "theme_profiles": """
            CREATE TABLE IF NOT EXISTS theme_profiles (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                theme_code TEXT UNIQUE,
                theme_name TEXT,
                mode TEXT,
                brand_name TEXT,
                description TEXT,
                default_theme INTEGER,
                active INTEGER
            );
        """,
        "theme_design_tokens": """
            CREATE TABLE IF NOT EXISTS theme_design_tokens (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                theme_id INTEGER,
                token_code TEXT,
                token_name TEXT,
                token_type TEXT,
                token_value TEXT,
                css_variable_name TEXT,
                dart_token_name TEXT,
                description TEXT,
                active INTEGER,
                FOREIGN KEY(theme_id) REFERENCES theme_profiles(id)
            );
        """,
        "component_theme_token_map": """
            CREATE TABLE IF NOT EXISTS component_theme_token_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                primecare_component_id INTEGER,
                theme_token_id INTEGER,
                usage_type TEXT,
                required INTEGER,
                default_value TEXT,
                FOREIGN KEY(primecare_component_id) REFERENCES primecare_ui_component_registry(id),
                FOREIGN KEY(theme_token_id) REFERENCES theme_design_tokens(id)
            );
        """,
        "layout_theme_token_map": """
            CREATE TABLE IF NOT EXISTS layout_theme_token_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                layout_template_id INTEGER,
                layout_region_id INTEGER,
                theme_token_id INTEGER,
                usage_type TEXT,
                required INTEGER,
                FOREIGN KEY(layout_template_id) REFERENCES app_layout_templates(id),
                FOREIGN KEY(layout_region_id) REFERENCES layout_regions(id),
                FOREIGN KEY(theme_token_id) REFERENCES theme_design_tokens(id)
            );
        """,
        "screen_theme_overrides": """
            CREATE TABLE IF NOT EXISTS screen_theme_overrides (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                section_id INTEGER,
                element_id INTEGER,
                theme_token_id INTEGER,
                override_value TEXT,
                reason TEXT,
                active INTEGER,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(section_id) REFERENCES screen_sections(id),
                FOREIGN KEY(element_id) REFERENCES screen_section_elements(id),
                FOREIGN KEY(theme_token_id) REFERENCES theme_design_tokens(id)
            );
        """,
        "responsive_profiles": """
            CREATE TABLE IF NOT EXISTS responsive_profiles (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                profile_code TEXT UNIQUE,
                profile_name TEXT,
                description TEXT,
                active INTEGER
            );
        """,
        "responsive_rules": """
            CREATE TABLE IF NOT EXISTS responsive_rules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                responsive_profile_id INTEGER,
                breakpoint_code TEXT,
                target_type TEXT,
                target_id INTEGER,
                behavior TEXT,
                column_count INTEGER,
                hidden INTEGER,
                order_override INTEGER,
                notes TEXT,
                FOREIGN KEY(responsive_profile_id) REFERENCES responsive_profiles(id)
            );
        """,
        "ui_accessibility_rules": """
            CREATE TABLE IF NOT EXISTS ui_accessibility_rules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                rule_code TEXT UNIQUE,
                rule_name TEXT,
                wcag_level TEXT,
                description TEXT,
                active INTEGER
            );
        """,
        "element_accessibility_implementation": """
            CREATE TABLE IF NOT EXISTS element_accessibility_implementation (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                section_id INTEGER,
                element_id INTEGER,
                rule_id INTEGER,
                aria_label_source TEXT,
                keyboard_required INTEGER,
                focus_order INTEGER,
                screen_reader_text TEXT,
                required INTEGER,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(section_id) REFERENCES screen_sections(id),
                FOREIGN KEY(element_id) REFERENCES screen_section_elements(id),
                FOREIGN KEY(rule_id) REFERENCES ui_accessibility_rules(id)
            );
        """,
        "qa_test_id_registry": """
            CREATE TABLE IF NOT EXISTS qa_test_id_registry (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                section_id INTEGER,
                element_id INTEGER,
                region_id INTEGER,
                test_id TEXT,
                test_id_type TEXT,
                selector_pattern TEXT,
                required INTEGER,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(section_id) REFERENCES screen_sections(id),
                FOREIGN KEY(element_id) REFERENCES screen_section_elements(id),
                FOREIGN KEY(region_id) REFERENCES layout_regions(id)
            );
        """,
        "ui_visual_states": """
            CREATE TABLE IF NOT EXISTS ui_visual_states (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                state_code TEXT UNIQUE,
                state_name TEXT,
                state_type TEXT,
                description TEXT,
                active INTEGER
            );
        """,
        "element_visual_state_map": """
            CREATE TABLE IF NOT EXISTS element_visual_state_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                element_id INTEGER,
                visual_state_id INTEGER,
                required INTEGER,
                implementation_notes TEXT,
                FOREIGN KEY(element_id) REFERENCES screen_section_elements(id),
                FOREIGN KEY(visual_state_id) REFERENCES ui_visual_states(id)
            );
        """,
        "component_selection_rules": """
            CREATE TABLE IF NOT EXISTS component_selection_rules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                element_type TEXT,
                section_type TEXT,
                layout_type TEXT,
                preferred_component_id INTEGER,
                fallback_component_id INTEGER,
                rule_description TEXT,
                active INTEGER,
                FOREIGN KEY(preferred_component_id) REFERENCES primecare_ui_component_registry(id),
                FOREIGN KEY(fallback_component_id) REFERENCES primecare_ui_component_registry(id)
            );
        """,
        "business_capabilities": """
            CREATE TABLE IF NOT EXISTS business_capabilities (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                capability_code TEXT UNIQUE,
                capability_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "business_processes": """
            CREATE TABLE IF NOT EXISTS business_processes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                process_code TEXT UNIQUE,
                process_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "workflows": """
            CREATE TABLE IF NOT EXISTS workflows (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                workflow_code TEXT UNIQUE,
                workflow_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "actors": """
            CREATE TABLE IF NOT EXISTS actors (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                actor_code TEXT UNIQUE,
                actor_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "permissions": """
            CREATE TABLE IF NOT EXISTS permissions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                permission_code TEXT UNIQUE,
                permission_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "app_modules": """
            CREATE TABLE IF NOT EXISTS app_modules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                module_code TEXT UNIQUE,
                module_name TEXT,
                app_id INTEGER,
                description TEXT,
                active INTEGER DEFAULT 1,
                FOREIGN KEY(app_id) REFERENCES apps(id)
            );
        """,
        "app_shells": """
            CREATE TABLE IF NOT EXISTS app_shells (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                shell_code TEXT UNIQUE,
                shell_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "sidebar_masters": """
            CREATE TABLE IF NOT EXISTS sidebar_masters (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                sidebar_code TEXT UNIQUE,
                sidebar_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "sidebar_groups": """
            CREATE TABLE IF NOT EXISTS sidebar_groups (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                group_code TEXT UNIQUE,
                group_name TEXT,
                display_order INTEGER,
                active INTEGER DEFAULT 1
            );
        """,
        "topbar_masters": """
            CREATE TABLE IF NOT EXISTS topbar_masters (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                topbar_code TEXT UNIQUE,
                topbar_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "global_features": """
            CREATE TABLE IF NOT EXISTS global_features (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                feature_code TEXT UNIQUE,
                feature_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "data_entities": """
            CREATE TABLE IF NOT EXISTS data_entities (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                entity_code TEXT UNIQUE,
                entity_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "entity_fields": """
            CREATE TABLE IF NOT EXISTS entity_fields (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                entity_id INTEGER,
                field_code TEXT,
                field_name TEXT,
                field_type TEXT,
                is_nullable INTEGER,
                description TEXT,
                FOREIGN KEY(entity_id) REFERENCES data_entities(id)
            );
        """,
        "dashboard_definitions": """
            CREATE TABLE IF NOT EXISTS dashboard_definitions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                dashboard_code TEXT UNIQUE,
                dashboard_name TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "dashboard_widgets": """
            CREATE TABLE IF NOT EXISTS dashboard_widgets (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                widget_code TEXT UNIQUE,
                widget_name TEXT,
                widget_type TEXT,
                description TEXT,
                active INTEGER DEFAULT 1
            );
        """,
        "dashboard_layouts": """
            CREATE TABLE IF NOT EXISTS dashboard_layouts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                dashboard_id INTEGER,
                layout_code TEXT,
                layout_name TEXT,
                layout_json TEXT,
                layout_xml TEXT,
                active INTEGER DEFAULT 1,
                FOREIGN KEY(dashboard_id) REFERENCES dashboard_definitions(id)
            );
        """,
        "dashboard_user_layouts": """
            CREATE TABLE IF NOT EXISTS dashboard_user_layouts (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                dashboard_id INTEGER,
                user_id TEXT,
                layout_json TEXT,
                layout_xml TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(dashboard_id) REFERENCES dashboard_definitions(id)
            );
        """,
        "dashboard_widget_api_map": """
            CREATE TABLE IF NOT EXISTS dashboard_widget_api_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                widget_id INTEGER,
                api_id INTEGER,
                active INTEGER DEFAULT 1,
                FOREIGN KEY(widget_id) REFERENCES dashboard_widgets(id),
                FOREIGN KEY(api_id) REFERENCES api_registry(id)
            );
        """,
        "dashboard_widget_permissions": """
            CREATE TABLE IF NOT EXISTS dashboard_widget_permissions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                widget_id INTEGER,
                role_id INTEGER,
                can_view INTEGER DEFAULT 1,
                can_edit INTEGER DEFAULT 0,
                FOREIGN KEY(widget_id) REFERENCES dashboard_widgets(id),
                FOREIGN KEY(role_id) REFERENCES roles(id)
            );
        """,
        "screenshot_registry": """
            CREATE TABLE IF NOT EXISTS screenshot_registry (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                screenshot_path TEXT,
                description TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(screen_id) REFERENCES screens(id)
            );
        """,
        "deployment_records": """
            CREATE TABLE IF NOT EXISTS deployment_records (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                environment TEXT,
                version TEXT,
                deployed_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
        """,
        "manual_review_checks": """
            CREATE TABLE IF NOT EXISTS manual_review_checks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                reviewer TEXT,
                status TEXT,
                remarks TEXT,
                checked_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(screen_id) REFERENCES screens(id)
            );
        """,
        "performance_requirements": """
            CREATE TABLE IF NOT EXISTS performance_requirements (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                max_load_time_ms INTEGER,
                description TEXT,
                FOREIGN KEY(screen_id) REFERENCES screens(id)
            );
        """,
        "languages": """
            CREATE TABLE IF NOT EXISTS languages (
                language_id INTEGER PRIMARY KEY AUTOINCREMENT,
                language_code TEXT UNIQUE,
                iso_code TEXT,
                language_name TEXT,
                native_name TEXT,
                culture_code TEXT,
                direction TEXT,
                enabled INTEGER,
                default_language INTEGER
            );
        """,
        "language_packs": """
            CREATE TABLE IF NOT EXISTS language_packs (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                pack_code TEXT UNIQUE,
                pack_name TEXT,
                language_id INTEGER,
                version TEXT,
                active INTEGER,
                FOREIGN KEY(language_id) REFERENCES languages(language_id)
            );
        """,
        "language_resources": """
            CREATE TABLE IF NOT EXISTS language_resources (
                resource_id INTEGER PRIMARY KEY AUTOINCREMENT,
                resource_key TEXT UNIQUE,
                resource_group TEXT,
                description TEXT,
                context TEXT,
                active INTEGER
            );
        """,
        "language_resource_groups": """
            CREATE TABLE IF NOT EXISTS language_resource_groups (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                group_code TEXT UNIQUE,
                group_name TEXT,
                description TEXT
            );
        """,
        "language_resource_values": """
            CREATE TABLE IF NOT EXISTS language_resource_values (
                translation_id INTEGER PRIMARY KEY AUTOINCREMENT,
                resource_id INTEGER,
                language_id INTEGER,
                translated_text TEXT,
                reviewed INTEGER,
                approved INTEGER,
                version TEXT,
                FOREIGN KEY(resource_id) REFERENCES language_resources(resource_id),
                FOREIGN KEY(language_id) REFERENCES languages(language_id)
            );
        """,
        "language_fallback_rules": """
            CREATE TABLE IF NOT EXISTS language_fallback_rules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                source_language_id INTEGER,
                fallback_language_id INTEGER,
                priority INTEGER,
                FOREIGN KEY(source_language_id) REFERENCES languages(language_id),
                FOREIGN KEY(fallback_language_id) REFERENCES languages(language_id)
            );
        """,
        "supported_cultures": """
            CREATE TABLE IF NOT EXISTS supported_cultures (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                culture_code TEXT UNIQUE,
                culture_name TEXT,
                locale TEXT
            );
        """,
        "user_language_preferences": """
            CREATE TABLE IF NOT EXISTS user_language_preferences (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                user_id TEXT,
                language_id INTEGER,
                culture_code TEXT,
                theme_id INTEGER,
                timezone TEXT,
                date_format TEXT,
                number_format TEXT,
                currency TEXT,
                FOREIGN KEY(language_id) REFERENCES languages(language_id)
            );
        """,
        "app_language_defaults": """
            CREATE TABLE IF NOT EXISTS app_language_defaults (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                app_id INTEGER,
                default_language_id INTEGER,
                fallback_language_id INTEGER,
                default_timezone TEXT,
                FOREIGN KEY(app_id) REFERENCES apps(id),
                FOREIGN KEY(default_language_id) REFERENCES languages(language_id),
                FOREIGN KEY(fallback_language_id) REFERENCES languages(language_id)
            );
        """,
        "screen_language_map": """
            CREATE TABLE IF NOT EXISTS screen_language_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                screen_id INTEGER,
                language_resource_id INTEGER,
                usage_type TEXT,
                FOREIGN KEY(screen_id) REFERENCES screens(id),
                FOREIGN KEY(language_resource_id) REFERENCES language_resources(resource_id)
            );
        """,
        "component_language_map": """
            CREATE TABLE IF NOT EXISTS component_language_map (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                component_id INTEGER,
                resource_id INTEGER,
                property_name TEXT,
                FOREIGN KEY(component_id) REFERENCES primecare_ui_component_registry(id),
                FOREIGN KEY(resource_id) REFERENCES language_resources(resource_id)
            );
        """,
        "translation_status": """
            CREATE TABLE IF NOT EXISTS translation_status (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                status_code TEXT UNIQUE,
                status_name TEXT
            );
        """,
        "translation_history": """
            CREATE TABLE IF NOT EXISTS translation_history (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                resource_value_id INTEGER,
                old_text TEXT,
                new_text TEXT,
                changed_by TEXT,
                changed_at TEXT DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY(resource_value_id) REFERENCES language_resource_values(translation_id)
            );
        """,
        "rtl_language_rules": """
            CREATE TABLE IF NOT EXISTS rtl_language_rules (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                language_id INTEGER,
                mirror_sidebar INTEGER,
                mirror_icons INTEGER,
                reverse_layout INTEGER,
                reverse_grid INTEGER,
                reverse_navigation INTEGER,
                FOREIGN KEY(language_id) REFERENCES languages(language_id)
            );
        """,
        "date_time_formats": """
            CREATE TABLE IF NOT EXISTS date_time_formats (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                culture_code TEXT,
                format_pattern TEXT,
                description TEXT
            );
        """,
        "number_formats": """
            CREATE TABLE IF NOT EXISTS number_formats (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                culture_code TEXT,
                decimal_separator TEXT,
                grouping_separator TEXT,
                format_pattern TEXT
            );
        """,
        "currency_formats": """
            CREATE TABLE IF NOT EXISTS currency_formats (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                currency TEXT,
                symbol TEXT,
                decimal_places INTEGER,
                symbol_position TEXT
            );
        """
    }

    # Drop existing tables to remodel freshly
    for table_name in tables_sql.keys():
        c.execute(f"DROP TABLE IF EXISTS {table_name}")

    # Create tables fresh
    for table_name, sql in tables_sql.items():
        c.execute(sql)
    conn.commit()

    # 2. Seed Default Themes
    c.execute("""
        INSERT INTO theme_profiles (theme_code, theme_name, mode, brand_name, description, default_theme, active)
        VALUES 
            ('light', 'Light Brand Theme', 'light', 'PrimeCare', 'Default light brand experience', 1, 1),
            ('dark', 'Dark Obsidian Theme', 'dark', 'PrimeCare', 'High contrast dark mode styling', 0, 1),
            ('high_contrast', 'High Contrast Theme', 'high_contrast', 'PrimeCare', 'A11y high contrast theme', 0, 1)
    """)
    conn.commit()

    # Fetch theme IDs
    c.execute("SELECT id, theme_code FROM theme_profiles")
    theme_ids = {row[1]: row[0] for row in c.fetchall()}

    # Seed Design Tokens
    shared_tokens = [
        ('font.family', 'font_family', 'typography', 'Inter, sans-serif', '--font-family', 'theme.typography.family', 'Default sans-serif font family'),
        ('font.size.body', 'font_size_body', 'typography', '14px', '--font-size-body', 'theme.typography.bodyMedium.fontSize', 'Default body text size'),
        ('font.size.caption', 'font_size_caption', 'typography', '12px', '--font-size-caption', 'theme.typography.bodySmall.fontSize', 'Small caption/helper size'),
        ('font.size.heading', 'font_size_heading', 'typography', '24px', '--font-size-heading', 'theme.typography.h2.fontSize', 'Title heading size'),
        ('font.weight.normal', 'font_weight_normal', 'typography', '400', '--font-weight-normal', 'FontWeight.normal', 'Regular font weight'),
        ('font.weight.bold', 'font_weight_bold', 'typography', '700', '--font-weight-bold', 'FontWeight.bold', 'Bold font weight'),
        
        ('spacing.xs', 'spacing_xs', 'spacing', '4px', '--spacing-xs', '4.0', 'Extra small spacing'),
        ('spacing.sm', 'spacing_sm', 'spacing', '8px', '--spacing-sm', '8.0', 'Small spacing'),
        ('spacing.md', 'spacing_md', 'spacing', '16px', '--spacing-md', '16.0', 'Medium spacing'),
        ('spacing.lg', 'spacing_lg', 'spacing', '24px', '--spacing-lg', '24.0', 'Large spacing'),
        ('spacing.xl', 'spacing_xl', 'spacing', '32px', '--spacing-xl', '32.0', 'Extra large spacing'),
        
        ('radius.sm', 'radius_sm', 'radius', '4px', '--radius-sm', '4.0', 'Small border radius'),
        ('radius.md', 'radius_md', 'radius', '8px', '--radius-md', '8.0', 'Medium border radius'),
        ('radius.lg', 'radius_lg', 'radius', '16px', '--radius-lg', '16.0', 'Large border radius'),
        ('radius.pill', 'radius_pill', 'radius', '999px', '--radius-pill', '999.0', 'Circular pill border radius'),
        
        ('shadow.card', 'shadow_card', 'shadow', '0 4px 6px -1px rgba(0, 0, 0, 0.1)', '--shadow-card', 'theme.shadows.card', 'Default card shadow'),
        ('shadow.topbar', 'shadow_topbar', 'shadow', '0 1px 3px rgba(0, 0, 0, 0.05)', '--shadow-topbar', 'theme.shadows.topbar', 'Header navigation shadow'),
        ('shadow.sidebar', 'shadow_sidebar', 'shadow', '0 8px 16px rgba(0, 0, 0, 0.04)', '--shadow-sidebar', 'theme.shadows.sidebar', 'Sidebar drawer shadow'),
        ('shadow.modal', 'shadow_modal', 'shadow', '0 20px 25px -5px rgba(0, 0, 0, 0.1)', '--shadow-modal', 'theme.shadows.modal', 'Popup overlay shadow'),
        
        ('breakpoint.mobile', 'breakpoint_mobile', 'breakpoint', '600px', '--breakpoint-mobile', '600.0', 'Mobile viewport width'),
        ('breakpoint.tablet', 'breakpoint_tablet', 'breakpoint', '1024px', '--breakpoint-tablet', '1024.0', 'Tablet viewport width'),
        ('breakpoint.desktop', 'breakpoint_desktop', 'breakpoint', '1440px', '--breakpoint-desktop', '1440.0', 'Desktop viewport width'),
        
        ('z.sidebar', 'z_sidebar', 'z_index', '100', '--z-sidebar', '100', 'Sidebar z-index'),
        ('z.topbar', 'z_topbar', 'z_index', '50', '--z-topbar', '50', 'Topbar z-index'),
        ('z.modal', 'z_modal', 'z_index', '200', '--z-modal', '200', 'Modal z-index'),
        ('z.toast', 'z_toast', 'z_index', '300', '--z-toast', '300', 'Toast alerts z-index')
    ]

    light_colors = {
        'color.primary': ('primary', '#0F172A', '--color-primary', 'theme.colors.primary', 'Primary brand color'),
        'color.primary_hover': ('primary_hover', '#1E293B', '--color-primary-hover', 'theme.colors.primaryHover', 'Primary hover color'),
        'color.secondary': ('secondary', '#475569', '--color-secondary', 'theme.colors.secondary', 'Secondary brand color'),
        'color.background': ('background', '#F8FAFC', '--color-background', 'theme.colors.background', 'App canvas background'),
        'color.surface': ('surface', '#FFFFFF', '--color-surface', 'theme.colors.surface', 'Card/surface background'),
        'color.surface_soft': ('surface_soft', '#F1F5F9', '--color-surface-soft', 'theme.colors.surfaceSoft', 'Muted card/surface background'),
        'color.text': ('text', '#1E293B', '--color-text', 'theme.colors.onBackground', 'Primary body text'),
        'color.text_muted': ('text_muted', '#64748B', '--color-text-muted', 'theme.colors.onBackgroundMuted', 'Secondary body text'),
        'color.border': ('border', '#E2E8F0', '--color-border', 'theme.colors.border', 'Divider and border color'),
        'color.success': ('success', '#10B981', '--color-success', 'theme.colors.success', 'Positive feedback states'),
        'color.warning': ('warning', '#F59E0B', '--color-warning', 'theme.colors.warning', 'Caution/alert states'),
        'color.danger': ('danger', '#EF4444', '--color-danger', 'theme.colors.error', 'Error feedback states'),
        'color.info': ('info', '#3B82F6', '--color-info', 'theme.colors.info', 'Informational states')
    }

    dark_colors = {
        'color.primary': ('primary', '#F8FAFC', '--color-primary', 'theme.colors.primary', 'Primary brand color'),
        'color.primary_hover': ('primary_hover', '#E2E8F0', '--color-primary-hover', 'theme.colors.primaryHover', 'Primary hover color'),
        'color.secondary': ('secondary', '#94A3B8', '--color-secondary', 'theme.colors.secondary', 'Secondary brand color'),
        'color.background': ('background', '#020617', '--color-background', 'theme.colors.background', 'App canvas background'),
        'color.surface': ('surface', '#0F172A', '--color-surface', 'theme.colors.surface', 'Card/surface background'),
        'color.surface_soft': ('surface_soft', '#1E293B', '--color-surface-soft', 'theme.colors.surfaceSoft', 'Muted card/surface background'),
        'color.text': ('text', '#F1F5F9', '--color-text', 'theme.colors.onBackground', 'Primary body text'),
        'color.text_muted': ('text_muted', '#94A3B8', '--color-text-muted', 'theme.colors.onBackgroundMuted', 'Secondary body text'),
        'color.border': ('border', '#334155', '--color-border', 'theme.colors.border', 'Divider and border color'),
        'color.success': ('success', '#34D399', '--color-success', 'theme.colors.success', 'Positive feedback states'),
        'color.warning': ('warning', '#FBBF24', '--color-warning', 'theme.colors.warning', 'Caution/alert states'),
        'color.danger': ('danger', '#F87171', '--color-danger', 'theme.colors.error', 'Error feedback states'),
        'color.info': ('info', '#60A5FA', '--color-info', 'theme.colors.info', 'Informational states')
    }

    high_contrast_colors = {
        'color.primary': ('primary', '#000000', '--color-primary', 'theme.colors.primary', 'Primary brand color'),
        'color.primary_hover': ('primary_hover', '#000000', '--color-primary-hover', 'theme.colors.primaryHover', 'Primary hover color'),
        'color.secondary': ('secondary', '#000000', '--color-secondary', 'theme.colors.secondary', 'Secondary brand color'),
        'color.background': ('background', '#FFFFFF', '--color-background', 'theme.colors.background', 'App canvas background'),
        'color.surface': ('surface', '#FFFFFF', '--color-surface', 'theme.colors.surface', 'Card/surface background'),
        'color.surface_soft': ('surface_soft', '#FFFFFF', '--color-surface-soft', 'theme.colors.surfaceSoft', 'Muted card/surface background'),
        'color.text': ('text', '#000000', '--color-text', 'theme.colors.onBackground', 'Primary body text'),
        'color.text_muted': ('text_muted', '#000000', '--color-text-muted', 'theme.colors.onBackgroundMuted', 'Secondary body text'),
        'color.border': ('border', '#000000', '--color-border', 'theme.colors.border', 'Divider and border color'),
        'color.success': ('success', '#00FF00', '--color-success', 'theme.colors.success', 'Positive feedback states'),
        'color.warning': ('warning', '#FFFF00', '--color-warning', 'theme.colors.warning', 'Caution/alert states'),
        'color.danger': ('danger', '#FF0000', '--color-danger', 'theme.colors.error', 'Error feedback states'),
        'color.info': ('info', '#0000FF', '--color-info', 'theme.colors.info', 'Informational states')
    }

    default_tokens = []
    for code, (name, val, css, dart, desc) in light_colors.items():
        default_tokens.append((theme_ids['light'], code, name, 'color', val, css, dart, desc, 1))
    for t in shared_tokens:
        default_tokens.append((theme_ids['light'], t[0], t[1], t[2], t[3], t[4], t[5], t[6], 1))

    for code, (name, val, css, dart, desc) in dark_colors.items():
        default_tokens.append((theme_ids['dark'], code, name, 'color', val, css, dart, desc, 1))
    for t in shared_tokens:
        default_tokens.append((theme_ids['dark'], t[0], t[1], t[2], t[3], t[4], t[5], t[6], 1))

    for code, (name, val, css, dart, desc) in high_contrast_colors.items():
        default_tokens.append((theme_ids['high_contrast'], code, name, 'color', val, css, dart, desc, 1))
    for t in shared_tokens:
        default_tokens.append((theme_ids['high_contrast'], t[0], t[1], t[2], t[3], t[4], t[5], t[6], 1))

    c.executemany("""
        INSERT INTO theme_design_tokens (theme_id, token_code, token_name, token_type, token_value, css_variable_name, dart_token_name, description, active)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, default_tokens)
    conn.commit()

    # 3. Seed Layout Templates
    c.execute("""
        INSERT INTO app_layout_templates (layout_code, layout_name, layout_type, description, has_sidebar, has_topbar, has_breadcrumbs, has_right_panel, has_bottom_action_bar, has_footer, content_slot_count, responsive_behavior, default_theme_id, active)
        VALUES 
            ('enterprise_admin', 'Enterprise Admin Layout', 'enterprise_admin', 'Sleek dark navigation sidebar layout for administrators', 1, 1, 1, 0, 0, 1, 3, 'responsive_grid', 1, 1),
            ('clinical_workspace', 'Clinical Workspace Layout', 'clinical_workspace', 'Widescreen high-density split workspace for practitioners', 1, 1, 1, 1, 1, 0, 4, 'split_flex', 1, 1),
            ('patient_portal', 'Patient Portal Layout', 'patient_portal', 'Clean, responsive consumer layout for patients', 0, 1, 0, 0, 0, 1, 2, 'centered_grid', 1, 1),
            ('mobile_worker', 'Mobile Worker Layout', 'mobile_worker', 'Dense mobile-optimized layout for fields operations', 1, 1, 0, 0, 1, 0, 1, 'stack', 1, 1),
            ('public_auth', 'Public Auth Layout', 'public_auth', 'Centered splash graphic and auth card layout', 0, 0, 0, 0, 0, 1, 1, 'centered', 1, 1),
            ('executive_dashboard', 'Executive Dashboard Layout', 'executive_dashboard', 'KPI grid split layout for business reporting', 1, 1, 1, 1, 0, 1, 4, 'split_flex', 1, 1)
    """)
    conn.commit()

    # Fetch layout templates
    c.execute("SELECT id, layout_code FROM app_layout_templates")
    layout_ids = {row[1]: row[0] for row in c.fetchall()}

    # Seed Layout Regions
    regions = [
        (layout_ids['clinical_workspace'], 'app-sidebar', 'App Sidebar Drawer', 'sidebar', 1, '280px', '100%', 'left', 1, 'scroll', 'collapsible', 'sidebar-drawer', 1),
        (layout_ids['clinical_workspace'], 'app-topbar', 'App Topbar Header', 'topbar', 2, '100%', '64px', 'top', 1, 'none', 'sticky', 'topbar-header', 1),
        (layout_ids['clinical_workspace'], 'main-content', 'Main Workspace Content', 'main_content', 3, 'flex-1', 'auto', 'center', 0, 'scroll', 'fluid', 'main-content-slot', 1),
        (layout_ids['clinical_workspace'], 'right-context-panel', 'Right Context Panel', 'right_panel', 4, '360px', '100%', 'right', 0, 'scroll', 'collapsible', 'context-panel-slot', 1),
        (layout_ids['clinical_workspace'], 'bottom-action-bar', 'Bottom Operations Action Bar', 'bottom_action_bar', 5, '100%', '72px', 'bottom', 1, 'none', 'sticky', 'bottom-action-bar-slot', 1),
        
        (layout_ids['enterprise_admin'], 'app-sidebar', 'App Sidebar Drawer', 'sidebar', 1, '280px', '100%', 'left', 1, 'scroll', 'collapsible', 'sidebar-drawer', 1),
        (layout_ids['enterprise_admin'], 'app-topbar', 'App Topbar Header', 'topbar', 2, '100%', '64px', 'top', 1, 'none', 'sticky', 'topbar-header', 1),
        (layout_ids['enterprise_admin'], 'main-content', 'Main Content Viewport', 'main_content', 3, 'flex-1', 'auto', 'center', 0, 'scroll', 'fluid', 'main-content-slot', 1),
        (layout_ids['enterprise_admin'], 'footer', 'App Footer', 'footer', 4, '100%', '48px', 'bottom', 0, 'none', 'fluid', 'footer-slot', 1),
        
        (layout_ids['public_auth'], 'main-content', 'Authentication Card Canvas', 'main_content', 1, '100%', '100%', 'center', 0, 'none', 'centered', 'auth-content-slot', 1),
        
        (layout_ids['executive_dashboard'], 'app-sidebar', 'App Sidebar Drawer', 'sidebar', 1, '280px', '100%', 'left', 1, 'scroll', 'collapsible', 'sidebar-drawer', 1),
        (layout_ids['executive_dashboard'], 'app-topbar', 'App Topbar Header', 'topbar', 2, '100%', '64px', 'top', 1, 'none', 'sticky', 'topbar-header', 1),
        (layout_ids['executive_dashboard'], 'main-content', 'Main Dashboard Grid', 'main_content', 3, 'flex-1', 'auto', 'center', 0, 'scroll', 'fluid', 'main-content-slot', 1),
        (layout_ids['executive_dashboard'], 'right-context-panel', 'Right KPI Detail Panel', 'right_panel', 4, '360px', '100%', 'right', 0, 'scroll', 'collapsible', 'context-panel-slot', 1),
        (layout_ids['executive_dashboard'], 'footer', 'App Footer', 'footer', 5, '100%', '48px', 'bottom', 0, 'none', 'fluid', 'footer-slot', 1),
        
        (layout_ids['mobile_worker'], 'app-sidebar', 'App Sidebar Drawer', 'sidebar', 1, '280px', '100%', 'left', 1, 'scroll', 'collapsible', 'sidebar-drawer', 1),
        (layout_ids['mobile_worker'], 'app-topbar', 'App Topbar Header', 'topbar', 2, '100%', '64px', 'top', 1, 'none', 'sticky', 'topbar-header', 1),
        (layout_ids['mobile_worker'], 'main-content', 'Mobile Main View', 'main_content', 3, '100%', 'auto', 'center', 0, 'scroll', 'stack', 'main-content-slot', 1),
        (layout_ids['mobile_worker'], 'bottom-action-bar', 'Mobile Bottom Action Bar', 'bottom_action_bar', 4, '100%', '64px', 'bottom', 1, 'none', 'sticky', 'bottom-action-bar-slot', 1),
        
        (layout_ids['patient_portal'], 'app-topbar', 'Portal Header Navigation', 'topbar', 1, '100%', '64px', 'top', 1, 'none', 'sticky', 'topbar-header', 1),
        (layout_ids['patient_portal'], 'main-content', 'Portal Main Content View', 'main_content', 2, '1200px', 'auto', 'center', 0, 'scroll', 'centered_grid', 'main-content-slot', 1),
        (layout_ids['patient_portal'], 'footer', 'Portal Footer', 'footer', 3, '100%', '64px', 'bottom', 0, 'none', 'fluid', 'footer-slot', 1)
    ]
    c.executemany("""
        INSERT INTO layout_regions (layout_template_id, region_code, region_name, region_type, display_order, width, height, position, sticky, scroll_behavior, responsive_behavior, test_id, active)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, regions)
    conn.commit()

    # 4. Seed Tag Registry
    tags = [
        ('main_content', 'Main Content', 'layout', 'main', 'main_content', 'Central screen viewport wrapper', 'main-content', 'main', 1),
        ('sidebar', 'Sidebar Panel', 'navigation', 'aside', 'sidebar', 'Side navigation drawer container', 'sidebar', 'navigation', 1),
        ('topbar', 'Topbar Header', 'navigation', 'header', 'topbar', 'Header navigation container', 'topbar', 'banner', 1),
        ('section', 'Screen Section', 'layout', 'section', 'section', 'Card or block enclosing widgets', 'section-${code}', 'region', 1),
        ('button', 'Primary Action Button', 'action', 'button', 'button', 'Encloses click trigger actions', 'btn-${code}', 'button', 1),
        ('input', 'Text Field Input', 'input', 'input', 'textbox', 'Text entry fields', 'input-${code}', 'textbox', 1),
        ('table', 'Grid Data Table', 'data_display', 'table', 'grid', 'Encloses relational database data', 'table-${code}', 'grid', 1),
        ('card', 'Dashboard Card Widget', 'layout', 'article', 'card', 'Metric display block', 'card-${code}', 'article', 1),
        ('dialog', 'Overlay Modal Window', 'overlay', 'dialog', 'dialog', 'Intercept focus alert box', 'dialog-${code}', 'dialog', 1),
        ('toast', 'Status Toast Alert', 'feedback', 'div', 'status', 'Self-dismissing notification banner', 'toast-${code}', 'status', 1)
    ]
    c.executemany("""
        INSERT INTO primecare_ui_tag_registry (tag_code, tag_name, tag_type, html_tag, semantic_role, purpose, default_testid_pattern, accessibility_role, active)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, tags)
    conn.commit()

    # 5. Seed Visual States
    states = [
        ('loading', 'Loading Spinner State', 'loading', 'Spinner representation during network async fetch', 1),
        ('empty', 'Empty List State', 'empty', 'Graphic/text shown when database query yields zero records', 1),
        ('error', 'Error Alert Banner State', 'error', 'Error text and retry triggers on network exceptions', 1),
        ('success', 'Active Success State', 'success', 'Standard fully-rendered layout view', 1),
        ('disabled', 'Inactive State', 'disabled', 'Grayed out inputs or non-interactive actions', 1),
        ('hover', 'Interactive Cursor Hover', 'hover', 'CSS hover shadow/glow alterations', 1)
    ]
    c.executemany("""
        INSERT INTO ui_visual_states (state_code, state_name, state_type, description, active)
        VALUES (?, ?, ?, ?, ?)
    """, states)
    conn.commit()

    # 6. Seed Accessibility Rules
    wcag_rules = [
        ('wcag_aria_labels', 'Enforce ARIA Labels', 'AA', 'All interactives must define descriptive labels', 1),
        ('wcag_keyboard_nav', 'Keyboard Tab Focus Navigation', 'A', 'All buttons/inputs must occupy a valid focus ring sequence', 1),
        ('wcag_color_contrast', 'Contrast Ratio Enforce', 'AA', 'Minimum text-to-background contrast must hit 4.5:1', 1)
    ]
    c.executemany("""
        INSERT INTO ui_accessibility_rules (rule_code, rule_name, wcag_level, description, active)
        VALUES (?, ?, ?, ?, ?)
    """, wcag_rules)
    conn.commit()

    # 7. Seed Responsive Profiles
    c.execute("""
        INSERT INTO responsive_profiles (profile_code, profile_name, description, active)
        VALUES 
            ('clinical_widescreen', 'Widescreen Clinical Profile', 'Enforces grid wrap wrapping columns for clinical displays', 1),
            ('admin_dashboard_grid', 'Admin Dashboard Profile', 'Desktop split pane scaling to single-pane stacks on tablet', 1),
            ('mobile_only', 'Mobile Stack Profile', 'Optimized single column view only', 1)
    """)
    conn.commit()

    c.execute("SELECT id, profile_code FROM responsive_profiles")
    resp_ids = {row[1]: row[0] for row in c.fetchall()}

    c.execute("SELECT id FROM layout_regions WHERE region_code = 'app-sidebar' LIMIT 1")
    sidebar_region_row = c.fetchone()
    sidebar_region_id = sidebar_region_row[0] if sidebar_region_row else 1

    resp_rules = [
        (resp_ids['clinical_widescreen'], 'desktop', 'layout_region', sidebar_region_id, 'visible', 3, 0, 1, 'Sidebar takes 3 cols on desktop'),
        (resp_ids['clinical_widescreen'], 'tablet', 'layout_region', sidebar_region_id, 'collapsible', 1, 0, 1, 'Sidebar collapses to drawer on tablet'),
        (resp_ids['clinical_widescreen'], 'mobile', 'layout_region', sidebar_region_id, 'hidden', 0, 1, 1, 'Sidebar hidden on mobile'),
        (resp_ids['admin_dashboard_grid'], 'desktop', 'layout_region', sidebar_region_id, 'visible', 2, 0, 1, 'Admin sidebar desktop'),
        (resp_ids['admin_dashboard_grid'], 'mobile', 'layout_region', sidebar_region_id, 'hidden', 0, 1, 1, 'Admin sidebar mobile')
    ]
    c.executemany("""
        INSERT INTO responsive_rules (responsive_profile_id, breakpoint_code, target_type, target_id, behavior, column_count, hidden, order_override, notes)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, resp_rules)
    conn.commit()

    # 8. Seed Component Registry
    scanned_components = [
        ('prime_button', 'Prime Button Component', 'button', 'PrimeButton', 'button', 'package:primecare_ui/primecare_ui.dart', 'packages/primecare_ui/lib/src/components/button.dart', 'Primary action button', '["button"]', '["label"]', '["variant"]', '["onPressed"]', '[]', '[]', 'const PrimeButton(label: "Click Me")', 1),
        ('prime_card', 'Prime Card Container', 'card', 'PrimeCard', 'div', 'package:primecare_ui/primecare_ui.dart', 'packages/primecare_ui/lib/src/components/card.dart', 'Default card layout wrapper', '["card"]', '[]', '["child"]', '[]', '[]', '[]', 'const PrimeCard(child: Text("Content"))', 1),
        ('prime_text_field', 'Prime Text Field Input', 'input', 'PrimeTextField', 'input', 'package:primecare_ui/primecare_ui.dart', 'packages/primecare_ui/lib/src/components/text_field.dart', 'Text form input', '["input"]', '["label"]', '["hint"]', '["onChanged"]', '[]', '[]', 'const PrimeTextField(label: "Email")', 1)
    ]
    c.executemany("""
        INSERT INTO primecare_ui_component_registry (component_code, component_name, component_type, dart_class_name, html_tag_equivalent, import_path, source_file_path, purpose, allowed_element_types_json, required_props_json, optional_props_json, event_props_json, accessibility_props_json, theme_token_requirements_json, example_usage, active)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, scanned_components)
    conn.commit()

    c.execute("SELECT id, component_code FROM primecare_ui_component_registry")
    comp_ids = {row[1]: row[0] for row in c.fetchall()}

    def get_preferred_component(elem_type):
        for code, cid in comp_ids.items():
            if elem_type in code:
                return cid
        return list(comp_ids.values())[0]

    selection_rules = [
        ('button', 'action_bar', 'clinical_workspace', comp_ids['prime_button'], comp_ids['prime_button'], 'Preferred button widget inside actions', 1),
        ('input', 'form', 'clinical_workspace', comp_ids['prime_text_field'], comp_ids['prime_text_field'], 'Default input widget in forms', 1)
    ]
    c.executemany("""
        INSERT INTO component_selection_rules (element_type, section_type, layout_type, preferred_component_id, fallback_component_id, rule_description, active)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """, selection_rules)
    conn.commit()

    # 9. Seed Business capabilities, processes, workflows, actors, permissions
    c.execute("""
        INSERT INTO business_capabilities (capability_code, capability_name, description, active)
        VALUES 
            ('core_care', 'Care Management', 'Core clinical activities and care plans', 1),
            ('finance', 'Financial Management', 'Billing, invoicing, ledger reconciliation', 1),
            ('ops', 'Operations & Staffing', 'Scheduling, visits matching', 1),
            ('outreach', 'Community Outreach', 'Outreach and franchise relations', 1)
    """)
    c.execute("""
        INSERT INTO business_processes (process_code, process_name, description, active)
        VALUES 
            ('patient_care', 'Patient Care Delivery', 'Visits and plan adherence checks', 1),
            ('billing', 'Client Invoicing', 'Invoice dispatch and payment collection', 1),
            ('staffing', 'Staffing Optimization', 'Caregiver allocation scheduling', 1)
    """)
    c.execute("""
        INSERT INTO workflows (workflow_code, workflow_name, description, active)
        VALUES 
            ('intake', 'Client Intake Registration', 'New client registration intake flow', 1),
            ('billing', 'Ledger Settlement', 'Invoicing and reconciliation workflow', 1),
            ('scheduling', 'Visits Matching Scheduler', 'Matching shifts to caregivers', 1)
    """)
    c.execute("""
        INSERT INTO actors (actor_code, actor_name, description, active)
        VALUES 
            ('human', 'Human Operator', 'App shell user agent', 1),
            ('system', 'System Background Daemon', 'Automated job runner', 1)
    """)
    c.execute("""
        INSERT INTO permissions (permission_code, permission_name, description, active)
        VALUES 
            ('read_all', 'Read All Resources', 'Allows viewing all screens and data', 1),
            ('write_all', 'Write All Resources', 'Allows editing all screens and data', 1)
    """)
    conn.commit()

    # 10. Seed Application modules, app shells, sidebars, topbars, features
    c.execute("""
        INSERT INTO app_modules (module_code, module_name, app_id, description, active)
        VALUES 
            ('clinical_module', 'Clinical Dashboard Module', 1, 'Holds clinical work screens', 1),
            ('finance_module', 'Ledger Hub Module', 2, 'Holds invoice/billing screens', 1)
    """)
    c.execute("""
        INSERT INTO app_shells (shell_code, shell_name, description, active)
        VALUES ('default_shell', 'Responsive App Shell Wrapper', 'Contains sidebar, topbar, content slot', 1)
    """)
    c.execute("""
        INSERT INTO sidebar_masters (sidebar_code, sidebar_name, description, active)
        VALUES ('main_sidebar', 'Standard Left Navigation', 'Standard left drawer menu sidebar', 1)
    """)
    c.execute("""
        INSERT INTO sidebar_groups (group_code, group_name, display_order, active)
        VALUES 
            ('overview', 'Overview', 1, 1),
            ('workflows', 'Workflows', 2, 1),
            ('tools', 'Tools', 3, 1)
    """)
    c.execute("""
        INSERT INTO topbar_masters (topbar_code, topbar_name, description, active)
        VALUES ('main_topbar', 'Standard Header Bar', 'Provides user info and search bar controls', 1)
    """)
    c.execute("""
        INSERT INTO global_features (feature_code, feature_name, description, active)
        VALUES 
            ('global_search', 'Predictive Text Search', 'Search engine for entities', 1),
            ('global_help', 'Customer Assistance', 'In-app help documentation widget', 1)
    """)
    conn.commit()

    # 11. Seed Data Entities and fields
    c.execute("""
        INSERT INTO data_entities (entity_code, entity_name, description, active)
        VALUES 
            ('Client', 'Client Record', 'Demographics and clinical profile', 1),
            ('Caregiver', 'Staff Record', 'Caregiver work logs and certifications', 1),
            ('Invoice', 'Invoice Ledger', 'Billable transactions', 1)
    """)
    c.execute("SELECT id FROM data_entities WHERE entity_code = 'Client'")
    client_ent_id = c.fetchone()[0]

    c.execute("""
        INSERT INTO entity_fields (entity_id, field_code, field_name, field_type, is_nullable, description)
        VALUES 
            (?, 'first_name', 'First Name', 'TEXT', 0, 'Client legal first name'),
            (?, 'last_name', 'Last Name', 'TEXT', 0, 'Client legal last name'),
            (?, 'date_of_birth', 'Date of Birth', 'DATE', 1, 'Client birthdate')
    """, (client_ent_id, client_ent_id, client_ent_id))
    conn.commit()

    # 12. Seed Dashboards, widgets, layouts
    c.execute("""
        INSERT INTO dashboard_definitions (dashboard_code, dashboard_name, description, active)
        VALUES ('rmt_dashboard', 'Remote Patient Care Dashboard', 'Active remote visits oversight dashboard', 1)
    """)
    c.execute("SELECT id FROM dashboard_definitions WHERE dashboard_code = 'rmt_dashboard'")
    dash_id = c.fetchone()[0]

    c.execute("""
        INSERT INTO dashboard_widgets (widget_code, widget_name, widget_type, description, active)
        VALUES 
            ('visit_counts', 'Visits Metric Summary', 'chart', 'Active visits counts representation', 1),
            ('revenue_metric', 'Revenue Summary', 'stat_badge', 'Monthly financial performance', 1)
    """)
    c.execute("SELECT id FROM dashboard_widgets WHERE widget_code = 'visit_counts'")
    wid_visit = c.fetchone()[0]

    # Active JSON and optional compatibility XML layout
    c.execute("""
        INSERT INTO dashboard_layouts (dashboard_id, layout_code, layout_name, layout_json, layout_xml, active)
        VALUES (?, 'rmt_default', 'RMT Default Layout', '{"columns": 3, "widgets": ["visit_counts"]}', '<dashboard><columns>3</columns></dashboard>', 1)
    """, (dash_id,))
    c.execute("""
        INSERT INTO dashboard_user_layouts (dashboard_id, user_id, layout_json, layout_xml)
        VALUES (?, 'admin_user', '{"columns": 2}', '<dashboard></dashboard>')
    """, (dash_id,))
    c.execute("""
        INSERT INTO dashboard_widget_api_map (widget_id, api_id, active)
        VALUES (?, 1, 1)
    """, (wid_visit,))
    c.execute("""
        INSERT INTO dashboard_widget_permissions (widget_id, role_id, can_view, can_edit)
        VALUES (?, 1, 1, 0)
    """, (wid_visit,))
    conn.commit()

    # 13. Seed Localization Layer
    # Supported Languages
    c.execute("""
        INSERT INTO languages (language_code, iso_code, language_name, native_name, culture_code, direction, enabled, default_language)
        VALUES 
            ('en', 'en', 'English', 'English', 'en-CA', 'LTR', 1, 1),
            ('fr', 'fr', 'French', 'Français', 'fr-CA', 'LTR', 1, 0),
            ('es', 'es', 'Spanish', 'Español', 'es-ES', 'LTR', 1, 0),
            ('ar', 'ar', 'Arabic', 'العربية', 'ar-AE', 'RTL', 1, 0),
            ('ur', 'ur', 'Urdu', 'اردو', 'ur-PK', 'RTL', 1, 0),
            ('hi', 'hi', 'Hindi', 'हिन्दी', 'hi-IN', 'LTR', 1, 0),
            ('gu', 'gu', 'Gujarati', 'ગુજરાતી', 'gu-IN', 'LTR', 1, 0),
            ('pa', 'pa', 'Punjabi', 'ਪੰਜਾਬੀ', 'pa-IN', 'LTR', 1, 0)
    """)
    conn.commit()

    c.execute("SELECT language_id, language_code FROM languages")
    lang_ids = {row[1]: row[0] for row in c.fetchall()}

    c.execute("""
        INSERT INTO language_packs (pack_code, pack_name, language_id, version, active)
        VALUES ('core_en', 'Core English Pack', ?, '1.0.0', 1)
    """, (lang_ids['en'],))

    # Supported Cultures
    c.execute("""
        INSERT INTO supported_cultures (culture_code, culture_name, locale)
        VALUES 
            ('en-CA', 'Canada (English)', 'en_CA'),
            ('en-US', 'United States (English)', 'en_US'),
            ('fr-CA', 'Canada (French)', 'fr_CA')
    """)
    
    # Time/Date & Number Formats
    c.execute("""
        INSERT INTO date_time_formats (culture_code, format_pattern, description)
        VALUES 
            ('en-CA', 'YYYY-MM-DD', 'Canadian Standard Date Pattern'),
            ('en-US', 'MM/DD/YYYY', 'US Standard Date Pattern'),
            ('fr-CA', 'DD/MM/YYYY', 'European Standard Date Pattern')
    """)
    c.execute("""
        INSERT INTO number_formats (culture_code, decimal_separator, grouping_separator, format_pattern)
        VALUES 
            ('en-US', '.', ',', '1,234.56'),
            ('fr-CA', ',', ' ', '1 234,56')
    """)
    c.execute("""
        INSERT INTO currency_formats (currency, symbol, decimal_places, symbol_position)
        VALUES 
            ('CAD', '$', 2, 'prefix'),
            ('USD', '$', 2, 'prefix'),
            ('EUR', '€', 2, 'suffix')
    """)
    
    # User Preference overrides
    c.execute("""
        INSERT INTO user_language_preferences (user_id, language_id, culture_code, theme_id, timezone, date_format, number_format, currency)
        VALUES ('admin_user', ?, 'en-CA', ?, 'EST', 'YYYY-MM-DD', '1,234.56', 'CAD')
    """, (lang_ids['en'], theme_ids['light']))

    # App Language defaults
    c.execute("""
        INSERT INTO app_language_defaults (app_id, default_language_id, fallback_language_id, default_timezone)
        VALUES (1, ?, ?, 'EST')
    """, (lang_ids['en'], lang_ids['en']))

    # Translation Statuses
    c.execute("""
        INSERT INTO translation_status (status_code, status_name)
        VALUES 
            ('not_started', 'Not Started'),
            ('machine_generated', 'Machine Generated'),
            ('needs_review', 'Needs Review'),
            ('approved', 'Approved'),
            ('deprecated', 'Deprecated')
    """)

    # RTL Rules
    c.execute("""
        INSERT INTO rtl_language_rules (language_id, mirror_sidebar, mirror_icons, reverse_layout, reverse_grid, reverse_navigation)
        VALUES 
            (?, 1, 1, 1, 1, 1),
            (?, 1, 1, 1, 1, 1)
    """, (lang_ids['ar'], lang_ids['ur']))
    conn.commit()

    # Seed resources & resource values
    resources = [
        ('login.username', 'login', 'Username Input Label', 'login form'),
        ('login.password', 'login', 'Password Input Label', 'login form'),
        ('login.sign_in', 'login', 'Sign In Trigger Button', 'login form'),
        ('sidebar.dashboard', 'sidebar', 'Sidebar Dashboard Navigation Link', 'sidebar menu'),
        ('sidebar.clients', 'sidebar', 'Sidebar Client Profile Navigation Link', 'sidebar menu'),
        ('sidebar.schedule', 'sidebar', 'Sidebar Caregiver Schedule Navigation Link', 'sidebar menu'),
        ('topbar.search', 'topbar', 'Topbar Search Field Placeholder', 'topbar controls'),
        ('topbar.notifications', 'topbar', 'Topbar Notification Trigger Button', 'topbar controls'),
        ('button.save', 'buttons', 'Save Record Button', 'shared actions'),
        ('button.cancel', 'buttons', 'Cancel Action Button', 'shared actions'),
        ('button.delete', 'buttons', 'Delete Record Trigger Button', 'shared actions'),
        ('dialog.confirm_delete', 'dialogs', 'Delete Confirmation Dialog Prompt', 'modal overlays'),
        ('dashboard.today_visits', 'dashboard', 'Today Visits Metric Count', 'clinical dashboards'),
        ('validation.required', 'validations', 'Field Required Message Label', 'form validators'),
        ('validation.email', 'validations', 'Email Incorrect Format Alert Label', 'form validators')
    ]
    
    resource_ids = {}
    for key_code, group, desc, ctx in resources:
        c.execute("""
            INSERT INTO language_resources (resource_key, resource_group, description, context, active)
            VALUES (?, ?, ?, ?, 1)
        """, (key_code, group, desc, ctx))
        resource_ids[key_code] = c.lastrowid

    # Translations values
    translations_to_insert = [
        # English
        (resource_ids['login.username'], lang_ids['en'], 'Username', 1, 1, '1.0'),
        (resource_ids['login.password'], lang_ids['en'], 'Password', 1, 1, '1.0'),
        (resource_ids['login.sign_in'], lang_ids['en'], 'Sign In', 1, 1, '1.0'),
        (resource_ids['sidebar.dashboard'], lang_ids['en'], 'Dashboard', 1, 1, '1.0'),
        (resource_ids['sidebar.clients'], lang_ids['en'], 'Client Directory', 1, 1, '1.0'),
        (resource_ids['sidebar.schedule'], lang_ids['en'], 'Shift Schedule', 1, 1, '1.0'),
        (resource_ids['topbar.search'], lang_ids['en'], 'Search platform resources...', 1, 1, '1.0'),
        (resource_ids['button.save'], lang_ids['en'], 'Save Changes', 1, 1, '1.0'),
        (resource_ids['button.cancel'], lang_ids['en'], 'Cancel', 1, 1, '1.0'),
        
        # French
        (resource_ids['login.username'], lang_ids['fr'], 'Nom d\'utilisateur', 1, 1, '1.0'),
        (resource_ids['login.password'], lang_ids['fr'], 'Mot de passe', 1, 1, '1.0'),
        (resource_ids['login.sign_in'], lang_ids['fr'], 'Se connecter', 1, 1, '1.0'),
        (resource_ids['sidebar.dashboard'], lang_ids['fr'], 'Tableau de bord', 1, 1, '1.0'),
        
        # Arabic (RTL test)
        (resource_ids['login.username'], lang_ids['ar'], 'اسم المستخدم', 1, 1, '1.0'),
        (resource_ids['login.password'], lang_ids['ar'], 'كلمة المرور', 1, 1, '1.0'),
        (resource_ids['login.sign_in'], lang_ids['ar'], 'تسجيل الدخول', 1, 1, '1.0')
    ]
    c.executemany("""
        INSERT INTO language_resource_values (resource_id, language_id, translated_text, reviewed, approved, version)
        VALUES (?, ?, ?, ?, ?, ?)
    """, translations_to_insert)
    conn.commit()

    # 14. Operations layer tables seeding
    c.execute("""
        INSERT INTO deployment_records (environment, version)
        VALUES 
            ('staging', '1.4.2'),
            ('production', '1.4.1')
    """)
    c.execute("""
        INSERT INTO performance_requirements (screen_id, max_load_time_ms, description)
        VALUES (1, 500, 'RMT Dashboard critical load budget')
    """)
    conn.commit()

    # 15. Map screens layout, theme, and placements dynamically
    print("Mapping layout regions and sections to screens...")
    
    # Fetch screens
    c.execute("SELECT id, screen_code, app_id, role_id FROM screens")
    screens = c.fetchall()

    # Fetch tags
    c.execute("SELECT id, tag_code FROM primecare_ui_tag_registry")
    tag_ids = {row[1]: row[0] for row in c.fetchall()}

    # Fetch accessibility rules
    c.execute("SELECT id, rule_code FROM ui_accessibility_rules")
    rule_ids = {row[1]: row[0] for row in c.fetchall()}

    # Fetch visual states
    c.execute("SELECT id, state_code FROM ui_visual_states")
    state_ids = {row[1]: row[0] for row in c.fetchall()}

    # Fetch layout regions
    c.execute("SELECT id, region_code, layout_template_id FROM layout_regions")
    regions_list = c.fetchall()
    regions_by_layout = {}
    for r in regions_list:
        regions_by_layout.setdefault(r[2], []).append((r[0], r[1]))

    # Perform mappings inside a batch transaction for high speed
    assignments = []
    placements = []
    element_maps = []
    qa_registries = []
    a11y_implementations = []
    visual_state_maps = []

    # Map layouts based on roles/screens names
    layout_ent = layout_ids['enterprise_admin']
    layout_clin = layout_ids['clinical_workspace']
    layout_auth = layout_ids['public_auth']
    
    for scr in screens:
        scr_id = scr[0]
        scr_code = scr[1]
        app_id = scr[2]
        role_id = scr[3]

        # Determine layout template
        if scr_code in ['login', 'forgot_password', 'mfa', 'reset_password']:
            template_id = layout_auth
        elif 'admin' in scr_code or 'manager' in scr_code or 'governance' in scr_code:
            template_id = layout_ent
        else:
            template_id = layout_clin

        # Default main content region selection
        avail_regions = regions_by_layout.get(template_id, [(1, 'main-content')])
        main_region_id = avail_regions[0][0]
        for rid, code in avail_regions:
            if 'main' in code:
                main_region_id = rid
                break

        assignments.append((scr_id, template_id, 'AppShell', main_region_id, 'admin_dashboard_grid', theme_ids['light'], 1))

        # Fetch sections for this screen
        c.execute("SELECT id, section_code, section_type, purpose FROM screen_sections WHERE screen_id = ?", (scr_id,))
        sections = c.fetchall()

        for idx, sec in enumerate(sections):
            sec_id = sec[0]
            sec_code = sec[1]
            sec_type = sec[2]
            
            # Map section placement to layout regions
            target_region_id = main_region_id
            for rid, code in avail_regions:
                if 'sidebar' in sec_code and 'sidebar' in code:
                    target_region_id = rid
                elif 'topbar' in sec_code and 'topbar' in code:
                    target_region_id = rid
                elif 'right' in sec_code and 'right' in code:
                    target_region_id = rid
                elif 'bottom' in sec_code and 'bottom' in code:
                    target_region_id = rid

            placements.append((scr_id, sec_id, target_region_id, idx + 1, 1, 1, 'fluid', 0, 0, 1, 'visible'))

            # Add QA test id for section
            qa_registries.append((scr_id, sec_id, None, None, f"section-{sec_code}", "section", f"//*[starts-with(@aria-label, 'section-{sec_code}')]", 1))

            # Fetch elements for this section
            c.execute("SELECT id, element_key, element_type, label, test_id FROM screen_section_elements WHERE section_id = ?", (sec_id,))
            elements = c.fetchall()

            for el in elements:
                el_id = el[0]
                el_key = el[1]
                el_type = el[2]
                el_label = el[3]
                test_id = el[4] or f"el-{el_key}"

                # Component selection
                pref_comp_id = get_preferred_component(el_type)
                
                # Tag selection
                tag_code = 'main_content'
                if 'btn' in el_type or 'button' in el_type:
                    tag_code = 'button'
                elif 'input' in el_type or 'field' in el_type:
                    tag_code = 'input'
                elif 'table' in el_type:
                    tag_code = 'table'
                elif 'card' in el_type:
                    tag_code = 'card'
                tag_id = tag_ids.get(tag_code, tag_ids['main_content'])

                element_maps.append((scr_id, sec_id, el_id, el_type, pref_comp_id, tag_id, 'primary', 'UI representation mapping', 1))

                # QA Test ID Registry
                qa_registries.append((scr_id, sec_id, el_id, None, test_id, "element", f"//*[starts-with(@aria-label, '{test_id}')]", 1))

                # Accessibility implementation mapping
                a11y_implementations.append((scr_id, sec_id, el_id, rule_ids['wcag_aria_labels'], "label", 1, 0, f"Accessibility prompt for {el_label}", 1))

                # Visual states
                visual_state_maps.append((el_id, state_ids['success'], 1, "Success fully-rendered visual state"))
                if 'btn' in el_type or 'button' in el_type:
                    visual_state_maps.append((el_id, state_ids['disabled'], 1, "Disabled button state"))
                    visual_state_maps.append((el_id, state_ids['hover'], 0, "Hover action highlights"))

    # Execute Bulk Assignments
    print("Writing Screen Layout Assignments...")
    c.executemany("""
        INSERT INTO screen_layout_assignment (screen_id, layout_template_id, app_shell_id, main_content_region_id, responsive_profile, theme_id, active)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """, assignments)

    print("Writing Section Region Placements...")
    c.executemany("""
        INSERT INTO section_region_placement (screen_id, section_id, layout_region_id, placement_order, grid_column_span, grid_row_span, width_behavior, sticky, collapsible, visible, responsive_behavior)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, placements)

    print("Writing Element Component Maps...")
    c.executemany("""
        INSERT INTO element_primecare_component_map (screen_id, section_id, element_id, element_type, primecare_component_id, tag_id, component_variant, usage_reason, required)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, element_maps)

    print("Writing QA Test ID Registries...")
    c.executemany("""
        INSERT INTO qa_test_id_registry (screen_id, section_id, element_id, region_id, test_id, test_id_type, selector_pattern, required)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, qa_registries)

    print("Writing Accessibility Implementations...")
    c.executemany("""
        INSERT INTO element_accessibility_implementation (screen_id, section_id, element_id, rule_id, aria_label_source, keyboard_required, focus_order, screen_reader_text, required)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, a11y_implementations)

    print("Writing Visual State Maps...")
    c.executemany("""
        INSERT INTO element_visual_state_map (element_id, visual_state_id, required, implementation_notes)
        VALUES (?, ?, ?, ?)
    """, visual_state_maps)

    # 16. Layout and Component Theme token map seeding
    c.execute("SELECT id FROM theme_design_tokens WHERE token_code = 'color.primary' LIMIT 1")
    t_primary = c.fetchone()
    t_primary = t_primary[0] if t_primary else 1

    c.execute("SELECT id FROM theme_design_tokens WHERE token_code = 'color.background' LIMIT 1")
    t_bg = c.fetchone()
    t_bg = t_bg[0] if t_bg else 1

    # Component Theme Token Map
    comp_theme_maps = []
    for comp_code, cid in comp_ids.items():
        comp_theme_maps.append((cid, t_primary, 'foreground', 1, 'theme.colors.primary'))
        comp_theme_maps.append((cid, t_bg, 'background', 1, 'theme.colors.background'))
    c.executemany("""
        INSERT INTO component_theme_token_map (primecare_component_id, theme_token_id, usage_type, required, default_value)
        VALUES (?, ?, ?, ?, ?)
    """, comp_theme_maps)

    # Layout Theme Token Map
    layout_theme_maps = []
    c.execute("SELECT id, layout_template_id, region_code FROM layout_regions")
    for r in c.fetchall():
        rid = r[0]
        lid = r[1]
        code = r[2]
        
        token_id = t_primary if 'sidebar' in code else t_bg
        layout_theme_maps.append((lid, rid, token_id, 'background', 1))
    c.executemany("""
        INSERT INTO layout_theme_token_map (layout_template_id, layout_region_id, theme_token_id, usage_type, required)
        VALUES (?, ?, ?, ?, ?)
    """, layout_theme_maps)

    conn.commit()
    conn.close()
    print("Database remodeled and populated successfully.")

if __name__ == "__main__":
    main()
