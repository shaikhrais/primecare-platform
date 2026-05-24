import sqlite3
import os

# Dynamically resolve DB_PATH relative to this file to allow portability and relative path sweeps
DB_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "governance.db")

def get_connection():
    """Returns a connection to the SQLite database with Foreign Keys enabled."""
    conn = sqlite3.connect(DB_PATH)
    conn.execute("PRAGMA foreign_keys = ON;")
    conn.row_factory = sqlite3.Row
    return conn

def init_db(force_reset=False):
    """Initializes the SQLite database schemas for the Ultimate 34-Table Software Governance Engine."""
    conn = get_connection()
    cursor = conn.cursor()
    
    if force_reset:
        print("Force resetting SQLite tables...")
        cursor.execute("PRAGMA foreign_keys = OFF;")
        
        tables_to_drop = [
            "release_gates",
            "api_failures",
            "user_sessions",
            "crash_reports",
            "runtime_logs",
            "rollback_operations",
            "rollback_snapshots",
            "agent_execution_runs",
            "field_dependencies",
            "field_validations",
            "form_fields",
            "forms",
            "dependency_impacts",
            "artifact_types",
            "dependency_versions",
            "security_findings",
            "performance_metrics",
            "health_checks",
            "incident_reports",
            "release_versions",
            "runtime_artifacts",
            "build_artifacts",
            "migration_history",
            "ci_pipeline_runs",
            "deployments",
            "artifact_dependencies",
            "feature_flags",
            "environment_configs",
            "branding_profiles",
            "layout_bindings",
            "router_mounts",
            "artifact_ownership",
            "package_files",
            "logical_apps",
            "physical_packages",
            "task_completion_checks",
            "test_results",
            "test_runs",
            "governance_reports",
            "governance_snapshots",
            "implementation_tasks",
            "drift_findings",
            "test_cases",
            "role_function_permissions",
            "role_screen_permissions",
            "screen_functions",
            "screen_components",
            "db_schema_columns",
            "db_schema_tables",
            "screen_api_links",
            "api_endpoints",
            "screen_file_links",
            "code_files",
            "screens",
            "roles",
            "apps",
            "orgs",
            "sidebar_items",
            "governance_logs",
            # Legacy/Obsolete tables to drop during transition
            "offices",
            "app_roles",
            "function_components",
            "data_entries",
            "transactions",
            "saved_reports",
            "dev_artifact_snapshots",
            "dev_change_logs",
            "schema_snapshots",
            "L1_apps"
        ]
        for t in tables_to_drop:
            cursor.execute(f"DROP TABLE IF EXISTS [{t}];")
            
        cursor.execute("PRAGMA foreign_keys = ON;")
        conn.commit()

    # 1. orgs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS orgs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_code TEXT UNIQUE NOT NULL,
      org_name TEXT NOT NULL,
      projects_path TEXT,
      status TEXT DEFAULT 'active',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    # 2. apps
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS apps (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_code TEXT UNIQUE NOT NULL,
      app_name TEXT NOT NULL,
      platform TEXT,
      framework TEXT,
      repo_name TEXT,
      root_path TEXT,
      publish_url TEXT,
      api_url TEXT,
      logo_url TEXT,
      status TEXT DEFAULT 'active',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE
    );
    """)

    # 3. roles
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS roles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      role_code TEXT UNIQUE NOT NULL,
      role_name TEXT NOT NULL,
      role_level INTEGER DEFAULT 1,
      status TEXT DEFAULT 'active',
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE
    );
    """)

    # 4. screens
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screens (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      screen_code TEXT NOT NULL,
      screen_name TEXT NOT NULL,
      route_path TEXT NOT NULL,
      layout_key TEXT,
      screen_type TEXT,
      implementation_status TEXT DEFAULT 'planned',
      file_path TEXT,
      deep_link_url TEXT,
      icon_key TEXT,
      physical_file_id INTEGER,
      logical_app_id INTEGER,
      route_name TEXT,
      is_route_active INTEGER DEFAULT 1,
      last_verified_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL,
      UNIQUE(app_id, screen_code),
      UNIQUE(app_id, route_path)
    );
    """)

    # 5. code_files
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS code_files (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      file_name TEXT NOT NULL,
      file_path TEXT UNIQUE NOT NULL,
      file_type TEXT,
      language TEXT,
      folder_path TEXT,
      is_generated INTEGER DEFAULT 0,
      status TEXT DEFAULT 'active',
      purpose TEXT,
      lines_of_code INTEGER DEFAULT 0,
      last_scanned_at TEXT,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL
    );
    """)

    # 6. screen_file_links
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_file_links (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      file_id INTEGER NOT NULL,
      link_type TEXT,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (file_id) REFERENCES code_files(id) ON DELETE CASCADE,
      UNIQUE(screen_id, file_id)
    );
    """)

    # 7. api_endpoints
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS api_endpoints (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      endpoint_code TEXT,
      route_path TEXT NOT NULL,
      http_method TEXT NOT NULL,
      controller_name TEXT,
      service_name TEXT,
      auth_required INTEGER DEFAULT 1,
      implementation_status TEXT DEFAULT 'planned',
      gateway_url TEXT,
      icon_key TEXT,
      request_schema TEXT,
      response_schema TEXT,
      permission_key TEXT,
      last_tested_at TEXT,
      health_status TEXT DEFAULT 'healthy',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL,
      UNIQUE(app_id, route_path, http_method)
    );
    """)

    # 8. screen_api_links
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_api_links (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      api_id INTEGER NOT NULL,
      purpose TEXT,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (api_id) REFERENCES api_endpoints(id) ON DELETE CASCADE,
      UNIQUE(screen_id, api_id)
    );
    """)

    # 9. db_schema_tables
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS db_schema_tables (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      table_name TEXT UNIQUE NOT NULL,
      table_type TEXT,
      status TEXT DEFAULT 'active',
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 10. db_schema_columns
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS db_schema_columns (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      table_id INTEGER NOT NULL,
      column_name TEXT NOT NULL,
      data_type TEXT NOT NULL,
      is_nullable INTEGER DEFAULT 1,
      is_primary INTEGER DEFAULT 0,
      is_foreign INTEGER DEFAULT 0,
      default_value TEXT,
      foreign_table_name TEXT,
      foreign_column_name TEXT,
      FOREIGN KEY (table_id) REFERENCES db_schema_tables(id) ON DELETE CASCADE,
      UNIQUE(table_id, column_name)
    );
    """)

    # 11. screen_components
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_components (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      component_code TEXT NOT NULL,
      component_name TEXT NOT NULL,
      component_type TEXT,
      data_cy TEXT,
      file_path TEXT,
      implementation_status TEXT DEFAULT 'planned',
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      UNIQUE(screen_id, component_code)
    );
    """)

    # 12. screen_functions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_functions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      function_code TEXT NOT NULL,
      function_name TEXT NOT NULL,
      function_type TEXT,
      api_id INTEGER,
      component_id INTEGER,
      implementation_status TEXT DEFAULT 'planned',
      permission_key TEXT,
      button_label TEXT,
      expected_result TEXT,
      test_required INTEGER DEFAULT 1,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL,
      FOREIGN KEY (component_id) REFERENCES screen_components(id) ON DELETE SET NULL,
      UNIQUE(screen_id, function_code)
    );
    """)

    # 13. role_screen_permissions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS role_screen_permissions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      role_id INTEGER NOT NULL,
      screen_id INTEGER NOT NULL,
      can_view INTEGER DEFAULT 0,
      can_create INTEGER DEFAULT 0,
      can_edit INTEGER DEFAULT 0,
      can_delete INTEGER DEFAULT 0,
      can_export INTEGER DEFAULT 0,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      UNIQUE(role_id, screen_id)
    );
    """)

    # 14. role_function_permissions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS role_function_permissions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      role_id INTEGER NOT NULL,
      function_id INTEGER NOT NULL,
      can_execute INTEGER DEFAULT 0,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
      FOREIGN KEY (function_id) REFERENCES screen_functions(id) ON DELETE CASCADE,
      UNIQUE(role_id, function_id)
    );
    """)

    # 15. test_cases
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS test_cases (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      test_name TEXT NOT NULL,
      test_type TEXT,
      file_path TEXT,
      related_screen_id INTEGER,
      related_api_id INTEGER,
      related_function_id INTEGER,
      related_component_id INTEGER,
      status TEXT DEFAULT 'active',
      last_run_status TEXT,
      priority TEXT DEFAULT 'medium',
      expected_result TEXT,
      last_run_at TEXT,
      coverage_type TEXT,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL,
      FOREIGN KEY (related_function_id) REFERENCES screen_functions(id) ON DELETE SET NULL,
      FOREIGN KEY (related_component_id) REFERENCES screen_components(id) ON DELETE SET NULL
    );
    """)

    # 16. test_runs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS test_runs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      run_name TEXT,
      run_type TEXT,
      status TEXT DEFAULT 'running',
      started_at TEXT DEFAULT CURRENT_TIMESTAMP,
      completed_at TEXT,
      summary_json TEXT,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 17. test_results
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS test_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      test_run_id INTEGER NOT NULL,
      test_case_id INTEGER,
      status TEXT NOT NULL,
      error_message TEXT,
      duration_ms INTEGER,
      screenshot_path TEXT,
      log_path TEXT,
      failed_step TEXT,
      retry_count INTEGER DEFAULT 0,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (test_run_id) REFERENCES test_runs(id) ON DELETE CASCADE,
      FOREIGN KEY (test_case_id) REFERENCES test_cases(id) ON DELETE SET NULL
    );
    """)

    # 18. drift_findings
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS drift_findings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      finding_type TEXT NOT NULL,
      severity TEXT DEFAULT 'medium',
      related_screen_id INTEGER,
      related_file_id INTEGER,
      related_api_id INTEGER,
      message TEXT NOT NULL,
      status TEXT DEFAULT 'open',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_file_id) REFERENCES code_files(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL
    );
    """)

    # 19. implementation_tasks
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS implementation_tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      task_title TEXT NOT NULL,
      task_description TEXT,
      priority TEXT DEFAULT 'medium',
      task_type TEXT,
      related_screen_id INTEGER,
      related_api_id INTEGER,
      related_file_id INTEGER,
      assigned_agent TEXT,
      status TEXT DEFAULT 'pending',
      source_finding_id INTEGER,
      completed_at TEXT,
      verified_by_test_run_id INTEGER,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (related_screen_id) REFERENCES screens(id) ON DELETE SET NULL,
      FOREIGN KEY (related_api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL,
      FOREIGN KEY (related_file_id) REFERENCES code_files(id) ON DELETE SET NULL
    );
    """)

    # 20. task_completion_checks
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS task_completion_checks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task_id INTEGER NOT NULL,
      check_name TEXT NOT NULL,
      check_status TEXT DEFAULT 'pending',
      evidence TEXT,
      checked_at TEXT,
      FOREIGN KEY (task_id) REFERENCES implementation_tasks(id) ON DELETE CASCADE
    );
    """)

    # 21. governance_snapshots
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_snapshots (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      snapshot_name TEXT,
      snapshot_type TEXT,
      snapshot_json TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 22. governance_reports
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      report_name TEXT NOT NULL,
      report_type TEXT,
      html_report_path TEXT,
      generated_by TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 23. sidebar_items
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS sidebar_items (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      parent_id INTEGER,
      screen_id INTEGER,
      label TEXT NOT NULL,
      icon TEXT,
      sort_order INTEGER DEFAULT 0,
      is_visible INTEGER DEFAULT 1,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE,
      FOREIGN KEY (parent_id) REFERENCES sidebar_items(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)

    # 24. governance_logs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS governance_logs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_id INTEGER,
      screen_id INTEGER,
      log_type TEXT,
      message TEXT NOT NULL,
      severity TEXT DEFAULT 'medium',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE SET NULL,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE SET NULL
    );
    """)

    # 25. physical_packages
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS physical_packages (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      package_code TEXT UNIQUE NOT NULL,
      package_name TEXT NOT NULL,
      root_path TEXT NOT NULL,
      package_type TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    # 26. logical_apps
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS logical_apps (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      org_id INTEGER NOT NULL,
      app_code TEXT UNIQUE NOT NULL,
      app_name TEXT NOT NULL,
      deployment_type TEXT,
      branding_key TEXT,
      environment TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE
    );
    """)

    # 27. package_files
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS package_files (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      package_id INTEGER NOT NULL,
      file_path TEXT UNIQUE NOT NULL,
      file_name TEXT NOT NULL,
      artifact_type TEXT,
      checksum TEXT,
      purpose TEXT,
      lines_of_code INTEGER DEFAULT 0,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (package_id) REFERENCES physical_packages(id) ON DELETE CASCADE
    );
    """)

    # 28. artifact_ownership
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS artifact_ownership (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      package_file_id INTEGER NOT NULL,
      ownership_type TEXT,
      mounted_route TEXT,
      authorization_policy TEXT,
      branding_override TEXT,
      screen_id INTEGER,
      role_id INTEGER,
      ownership_status TEXT,
      verified_at TEXT,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (package_file_id) REFERENCES package_files(id) ON DELETE CASCADE,
      UNIQUE(logical_app_id, package_file_id)
    );
    """)

    # 29. router_mounts
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS router_mounts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      screen_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      route_path TEXT NOT NULL,
      router_name TEXT,
      is_active INTEGER DEFAULT 1,
      route_name TEXT,
      guard_name TEXT,
      middleware_key TEXT,
      deep_link_url TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL,
      UNIQUE(logical_app_id, route_path)
    );
    """)

    # 30. layout_bindings
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS layout_bindings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      screen_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      layout_name TEXT NOT NULL,
      binding_type TEXT,
      layout_file_id INTEGER,
      responsive_profile TEXT,
      breakpoint_policy TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL,
      UNIQUE(logical_app_id, screen_id)
    );
    """)

    # 31. branding_profiles
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS branding_profiles (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER UNIQUE NOT NULL,
      theme_mode TEXT DEFAULT 'dark',
      primary_color TEXT,
      secondary_color TEXT,
      font_family TEXT,
      logo_url TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 32. environment_configs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS environment_configs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      env_key TEXT NOT NULL,
      env_value TEXT,
      environment_name TEXT NOT NULL,
      is_sensitive INTEGER DEFAULT 0,
      secret_ref TEXT,
      value_hash TEXT,
      is_required INTEGER DEFAULT 1,
      validation_status TEXT DEFAULT 'valid',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      UNIQUE(logical_app_id, env_key, environment_name)
    );
    """)

    # 33. feature_flags
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS feature_flags (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      flag_key TEXT NOT NULL,
      flag_name TEXT NOT NULL,
      is_enabled INTEGER DEFAULT 0,
      description TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      UNIQUE(logical_app_id, flag_key)
    );
    """)

    # 34. artifact_dependencies
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS artifact_dependencies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      source_type TEXT NOT NULL,
      source_id INTEGER NOT NULL,
      target_type TEXT NOT NULL,
      target_id INTEGER NOT NULL,
      dependency_type TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      UNIQUE(source_type, source_id, target_type, target_id, dependency_type)
    );
    """)

    # 35. deployments
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS deployments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      environment TEXT NOT NULL,
      deployment_status TEXT NOT NULL,
      deployed_at TEXT NOT NULL,
      version TEXT,
      changelog TEXT,
      deployed_by TEXT,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 36. ci_pipeline_runs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS ci_pipeline_runs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      run_number INTEGER NOT NULL,
      commit_sha TEXT NOT NULL,
      branch TEXT NOT NULL,
      pipeline_status TEXT NOT NULL,
      triggered_by TEXT NOT NULL,
      started_at TEXT NOT NULL,
      completed_at TEXT,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 37. migration_history
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS migration_history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      migration_name TEXT UNIQUE NOT NULL,
      batch_number INTEGER NOT NULL,
      applied_at TEXT NOT NULL,
      schema_snapshot TEXT,
      FOREIGN KEY (app_id) REFERENCES apps(id) ON DELETE CASCADE
    );
    """)

    # 38. build_artifacts
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS build_artifacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      pipeline_run_id INTEGER NOT NULL,
      runtime_artifact_id INTEGER,
      artifact_name TEXT NOT NULL,
      file_path TEXT NOT NULL,
      file_size INTEGER NOT NULL,
      checksum TEXT NOT NULL,
      created_at TEXT NOT NULL,
      FOREIGN KEY (pipeline_run_id) REFERENCES ci_pipeline_runs(id) ON DELETE CASCADE,
      FOREIGN KEY (runtime_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL
    );
    """)

    # 39. runtime_artifacts
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS runtime_artifacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      artifact_type TEXT NOT NULL,
      artifact_code TEXT UNIQUE NOT NULL,
      artifact_name TEXT NOT NULL,
      physical_path TEXT,
      logical_app_id INTEGER,
      package_id INTEGER,
      status TEXT DEFAULT 'active',
      health_status TEXT DEFAULT 'healthy',
      deployment_status TEXT DEFAULT 'deployed',
      version TEXT,
      checksum TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE SET NULL,
      FOREIGN KEY (package_id) REFERENCES physical_packages(id) ON DELETE SET NULL
    );
    """)

    # 40. release_versions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS release_versions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      version_code TEXT NOT NULL,
      release_status TEXT DEFAULT 'draft',
      changelog TEXT,
      released_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      UNIQUE(logical_app_id, version_code)
    );
    """)

    # 41. incident_reports
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS incident_reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      incident_code TEXT UNIQUE NOT NULL,
      severity TEXT NOT NULL,
      summary TEXT NOT NULL,
      description TEXT,
      affected_artifact_id INTEGER,
      status TEXT DEFAULT 'open',
      resolved_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (affected_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL
    );
    """)

    # 42. health_checks
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS health_checks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      check_name TEXT NOT NULL,
      target_url TEXT,
      check_type TEXT,
      status TEXT DEFAULT 'healthy',
      response_time_ms INTEGER,
      last_checked_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 43. performance_metrics
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS performance_metrics (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      metric_name TEXT NOT NULL,
      target_artifact_id INTEGER,
      latency_ms INTEGER NOT NULL,
      percentile REAL,
      recorded_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (target_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE CASCADE
    );
    """)

    # 44. security_findings
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS security_findings (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      vulnerability_code TEXT UNIQUE NOT NULL,
      title TEXT NOT NULL,
      severity TEXT NOT NULL,
      description TEXT,
      affected_artifact_id INTEGER,
      remediation_status TEXT DEFAULT 'unresolved',
      discovered_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (affected_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE SET NULL
    );
    """)

    # 45. dependency_versions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS dependency_versions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      package_id INTEGER NOT NULL,
      dependency_name TEXT NOT NULL,
      declared_version TEXT NOT NULL,
      resolved_version TEXT,
      license_type TEXT,
      vulnerability_count INTEGER DEFAULT 0,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (package_id) REFERENCES physical_packages(id) ON DELETE CASCADE,
      UNIQUE(package_id, dependency_name)
    );
    """)

    # 46. artifact_types
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS artifact_types (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type_code TEXT UNIQUE NOT NULL,
      type_name TEXT NOT NULL,
      parent_type TEXT,
      validation_rules TEXT
    );
    """)

    # 47. dependency_impacts
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS dependency_impacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      source_artifact_id INTEGER NOT NULL,
      target_artifact_id INTEGER NOT NULL,
      impact_depth INTEGER NOT NULL,
      impact_type TEXT,
      criticality TEXT,
      description TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (source_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE CASCADE,
      FOREIGN KEY (target_artifact_id) REFERENCES runtime_artifacts(id) ON DELETE CASCADE
    );
    """)

    # 48. forms
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS forms (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      screen_id INTEGER NOT NULL,
      form_code TEXT UNIQUE NOT NULL,
      form_name TEXT NOT NULL,
      submit_method TEXT DEFAULT 'POST',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (screen_id) REFERENCES screens(id) ON DELETE CASCADE
    );
    """)

    # 49. form_fields
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS form_fields (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      form_id INTEGER NOT NULL,
      field_code TEXT NOT NULL,
      field_name TEXT NOT NULL,
      field_type TEXT NOT NULL,
      is_required INTEGER DEFAULT 0,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (form_id) REFERENCES forms(id) ON DELETE CASCADE,
      UNIQUE(form_id, field_code)
    );
    """)

    # 50. field_validations
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS field_validations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      field_id INTEGER NOT NULL,
      validation_type TEXT NOT NULL,
      validation_rule TEXT NOT NULL,
      error_message TEXT NOT NULL,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (field_id) REFERENCES form_fields(id) ON DELETE CASCADE
    );
    """)

    # 51. field_dependencies
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS field_dependencies (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      field_id INTEGER NOT NULL,
      depends_on_field_id INTEGER NOT NULL,
      dependency_type TEXT NOT NULL,
      trigger_value TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (field_id) REFERENCES form_fields(id) ON DELETE CASCADE,
      FOREIGN KEY (depends_on_field_id) REFERENCES form_fields(id) ON DELETE CASCADE
    );
    """)

    # 52. agent_execution_runs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS agent_execution_runs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      run_code TEXT UNIQUE NOT NULL,
      agent_name TEXT NOT NULL,
      action_taken TEXT NOT NULL,
      before_snapshot TEXT,
      after_snapshot TEXT,
      status TEXT NOT NULL,
      rollback_supported INTEGER DEFAULT 0,
      error_log TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP
    );
    """)

    # 53. rollback_snapshots
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS rollback_snapshots (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      snapshot_code TEXT UNIQUE NOT NULL,
      logical_app_id INTEGER NOT NULL,
      schema_snapshot TEXT,
      data_snapshot TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 54. rollback_operations
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS rollback_operations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      snapshot_id INTEGER NOT NULL,
      operation_type TEXT NOT NULL,
      execution_status TEXT DEFAULT 'pending',
      executed_by TEXT,
      started_at TEXT,
      completed_at TEXT,
      error_message TEXT,
      FOREIGN KEY (snapshot_id) REFERENCES rollback_snapshots(id) ON DELETE CASCADE
    );
    """)

    # 55. runtime_logs
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS runtime_logs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      log_level TEXT NOT NULL,
      message TEXT NOT NULL,
      trace_id TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 56. crash_reports
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS crash_reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      crash_code TEXT UNIQUE NOT NULL,
      error_type TEXT NOT NULL,
      stack_trace TEXT NOT NULL,
      device_info TEXT,
      session_id TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE
    );
    """)

    # 57. user_sessions
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS user_sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      session_token TEXT UNIQUE NOT NULL,
      role_id INTEGER,
      device_platform TEXT,
      ip_address TEXT,
      started_at TEXT DEFAULT CURRENT_TIMESTAMP,
      ended_at TEXT,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE SET NULL
    );
    """)

    # 58. api_failures
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS api_failures (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      logical_app_id INTEGER NOT NULL,
      api_id INTEGER,
      error_code INTEGER NOT NULL,
      latency_ms INTEGER,
      request_payload TEXT,
      response_payload TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (logical_app_id) REFERENCES logical_apps(id) ON DELETE CASCADE,
      FOREIGN KEY (api_id) REFERENCES api_endpoints(id) ON DELETE SET NULL
    );
    """)

    # 59. release_gates
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS release_gates (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      release_version_id INTEGER NOT NULL,
      gate_name TEXT NOT NULL,
      is_passed INTEGER DEFAULT 0,
      evidence TEXT,
      evaluated_at TEXT,
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (release_version_id) REFERENCES release_versions(id) ON DELETE CASCADE,
      UNIQUE(release_version_id, gate_name)
    );
    """)

    # Create optimized indexing structures
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_apps_org ON apps(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_roles_org ON roles(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_screens_app ON screens(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_code_files_app ON code_files(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_api_endpoints_app ON api_endpoints(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_db_schema_tables_app ON db_schema_tables(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_permissions_role ON role_screen_permissions(role_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_permissions_screen ON role_screen_permissions(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_components_screen ON screen_components(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_functions_screen ON screen_functions(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_drift_findings_app ON drift_findings(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_tasks_app ON implementation_tasks(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_snapshots_app ON governance_snapshots(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_reports_app ON governance_reports(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_test_runs_app ON test_runs(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_test_results_run ON test_results(test_run_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_test_results_case ON test_results(test_case_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_completion_checks_task ON task_completion_checks(task_id);")
    
    # 10 New Indexes
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_pp_code ON physical_packages(package_code);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_la_org ON logical_apps(org_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_pf_pkg ON package_files(package_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ao_app ON artifact_ownership(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ao_file ON artifact_ownership(package_file_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_rm_app ON router_mounts(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_lb_app ON layout_bindings(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_bp_app ON branding_profiles(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ec_app ON environment_configs(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ff_app ON feature_flags(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ad_source ON artifact_dependencies(source_type, source_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ad_target ON artifact_dependencies(target_type, target_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_deployments_la ON deployments(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_ci_pipeline_runs_la ON ci_pipeline_runs(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_migration_history_app ON migration_history(app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_build_artifacts_run ON build_artifacts(pipeline_run_id);")
    
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_runtime_artifacts_la ON runtime_artifacts(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_release_versions_la ON release_versions(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_incident_reports_la ON incident_reports(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_health_checks_la ON health_checks(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_performance_metrics_la ON performance_metrics(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_security_findings_la ON security_findings(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_dependency_versions_pkg ON dependency_versions(package_id);")

    # Phase 7 New Indexes
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_dependency_impacts_src ON dependency_impacts(source_artifact_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_dependency_impacts_tgt ON dependency_impacts(target_artifact_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_forms_screen ON forms(screen_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_form_fields_form ON form_fields(form_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_field_validations_field ON field_validations(field_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_field_dependencies_field ON field_dependencies(field_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_rollback_snapshots_la ON rollback_snapshots(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_rollback_operations_snap ON rollback_operations(snapshot_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_runtime_logs_la ON runtime_logs(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_crash_reports_la ON crash_reports(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_user_sessions_la ON user_sessions(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_api_failures_la ON api_failures(logical_app_id);")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_release_gates_ver ON release_gates(release_version_id);")

    conn.commit()
    conn.close()
    print("PrimeCare 59-Table Relational Ultimate Software Governance SQLite Database schemas fully initialized.")

if __name__ == "__main__":
    init_db()
