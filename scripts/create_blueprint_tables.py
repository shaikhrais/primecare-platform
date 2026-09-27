import sqlite3
import os

DB_PATH = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\.agents\governance\governance.db"

def main():
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()
    cur.execute("PRAGMA foreign_keys = ON;")

    # 1. screen_implementation_blueprints
    cur.execute("""
    CREATE TABLE IF NOT EXISTS screen_implementation_blueprints (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        app_id INTEGER,
        role_id INTEGER,
        screen_purpose TEXT,
        business_context TEXT,
        user_goal TEXT,
        primary_workflow TEXT,
        secondary_workflows TEXT,
        data_dependencies TEXT,
        api_dependencies TEXT,
        expected_user_journey TEXT,
        implementation_notes TEXT,
        integration_notes TEXT,
        status TEXT DEFAULT 'planned',
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id)
    );
    """)

    # 2. section_function_descriptions
    cur.execute("""
    CREATE TABLE IF NOT EXISTS section_function_descriptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        section_id INTEGER NOT NULL,
        section_code TEXT NOT NULL,
        section_name TEXT NOT NULL,
        section_type TEXT NOT NULL,
        functional_purpose TEXT,
        user_interaction_description TEXT,
        data_displayed TEXT,
        data_entered TEXT,
        api_dependency_notes TEXT,
        state_handling_notes TEXT,
        implementation_notes TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id),
        FOREIGN KEY (section_id) REFERENCES screen_sections(id)
    );
    """)

    # 3. element_function_descriptions
    cur.execute("""
    CREATE TABLE IF NOT EXISTS element_function_descriptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        section_id INTEGER NOT NULL,
        element_id INTEGER NOT NULL,
        element_key TEXT NOT NULL,
        element_type TEXT NOT NULL,
        label TEXT,
        functional_purpose TEXT,
        user_action TEXT,
        expected_behavior TEXT,
        validation_rules TEXT,
        api_trigger TEXT,
        api_usage TEXT,
        success_behavior TEXT,
        error_behavior TEXT,
        empty_state_behavior TEXT,
        disabled_state_behavior TEXT,
        test_expectation TEXT,
        implementation_notes TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id),
        FOREIGN KEY (section_id) REFERENCES screen_sections(id),
        FOREIGN KEY (element_id) REFERENCES screen_section_elements(id)
    );
    """)

    # 4. button_action_definitions
    cur.execute("""
    CREATE TABLE IF NOT EXISTS button_action_definitions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        section_id INTEGER NOT NULL,
        element_id INTEGER NOT NULL,
        button_key TEXT NOT NULL,
        button_label TEXT,
        action_type TEXT NOT NULL,
        api_id INTEGER,
        endpoint_path TEXT,
        method TEXT,
        request_payload_description TEXT,
        success_result TEXT,
        failure_result TEXT,
        confirmation_required INTEGER DEFAULT 0,
        navigation_after_success TEXT,
        toast_or_message TEXT,
        test_id TEXT NOT NULL,
        implementation_status TEXT DEFAULT 'planned',
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id),
        FOREIGN KEY (section_id) REFERENCES screen_sections(id),
        FOREIGN KEY (element_id) REFERENCES screen_section_elements(id)
    );
    """)

    # 5. screen_integration_map
    cur.execute("""
    CREATE TABLE IF NOT EXISTS screen_integration_map (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        app_id INTEGER,
        role_id INTEGER,
        route_path TEXT NOT NULL,
        main_file_path TEXT NOT NULL,
        section_file_paths_json TEXT NOT NULL,
        api_ids_json TEXT NOT NULL,
        test_definition_ids_json TEXT NOT NULL,
        sidebar_label TEXT,
        required_auth INTEGER DEFAULT 1,
        required_role TEXT,
        integration_summary TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id)
    );
    """)

    # 6. api_usage_blueprints
    cur.execute("""
    CREATE TABLE IF NOT EXISTS api_usage_blueprints (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        api_id INTEGER NOT NULL,
        api_code TEXT NOT NULL,
        api_name TEXT NOT NULL,
        endpoint_path TEXT NOT NULL,
        method TEXT NOT NULL,
        used_by_screen_ids_json TEXT NOT NULL,
        purpose TEXT,
        request_model_description TEXT,
        response_model_description TEXT,
        loading_state_required INTEGER DEFAULT 1,
        empty_state_required INTEGER DEFAULT 1,
        error_state_required INTEGER DEFAULT 1,
        retry_required INTEGER DEFAULT 1,
        security_notes TEXT,
        implementation_notes TEXT,
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (api_id) REFERENCES api_registry(id)
    );
    """)

    # 7. screen_implementation_tasks
    cur.execute("""
    CREATE TABLE IF NOT EXISTS screen_implementation_tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        screen_id INTEGER NOT NULL,
        task_order INTEGER NOT NULL,
        task_type TEXT NOT NULL,
        task_title TEXT NOT NULL,
        task_description TEXT NOT NULL,
        file_path TEXT,
        depends_on_task_id INTEGER,
        status TEXT DEFAULT 'planned',
        created_at TEXT DEFAULT CURRENT_TIMESTAMP,
        updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (screen_id) REFERENCES screens(id)
    );
    """)

    conn.commit()
    conn.close()
    print("All intelligence and description/function tables created successfully!")

if __name__ == "__main__":
    main()
