-- Schema Migration: V1__init
-- Created: 2026-07-14

-- 1. Schema Migrations Table
CREATE TABLE IF NOT EXISTS schema_migrations (
    version TEXT PRIMARY KEY,
    description TEXT NOT NULL,
    applied_at TEXT NOT NULL
);

-- 2. Applications Table
CREATE TABLE IF NOT EXISTS applications (
    application_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_key TEXT NOT NULL UNIQUE,
    application_name TEXT NOT NULL,
    base_url TEXT,
    api_base_url TEXT,
    environment TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- 3. Screens Table
CREATE TABLE IF NOT EXISTS screens (
    screen_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    screen_key TEXT NOT NULL,
    screen_name TEXT NOT NULL,
    route TEXT NOT NULL,
    page_class TEXT,
    module_name TEXT,
    required_role TEXT,
    implementation_status TEXT NOT NULL DEFAULT 'UNKNOWN',
    verification_status TEXT NOT NULL DEFAULT 'NOT_TESTED',
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(application_id, screen_key),
    FOREIGN KEY(application_id) REFERENCES applications(application_id)
);

-- 4. Testing Layers Table
CREATE TABLE IF NOT EXISTS testing_layers (
    layer_id INTEGER PRIMARY KEY,
    layer_code TEXT NOT NULL UNIQUE,
    layer_name TEXT NOT NULL,
    layer_order INTEGER NOT NULL UNIQUE,
    description TEXT NOT NULL,
    blocking INTEGER NOT NULL DEFAULT 1,
    active INTEGER NOT NULL DEFAULT 1
);

-- 5. Screen Layer Requirements Table
CREATE TABLE IF NOT EXISTS screen_layer_requirements (
    requirement_id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_id INTEGER NOT NULL,
    layer_id INTEGER NOT NULL,
    required INTEGER NOT NULL DEFAULT 1,
    dependency_layer_id INTEGER,
    configuration_json TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(screen_id, layer_id),
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY(layer_id) REFERENCES testing_layers(layer_id)
);

-- 6. UI Components Table
CREATE TABLE IF NOT EXISTS ui_components (
    component_id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_id INTEGER NOT NULL,
    component_key TEXT NOT NULL,
    component_name TEXT NOT NULL,
    component_type TEXT NOT NULL,
    locator_strategy TEXT,
    locator_value TEXT,
    data_cy TEXT,
    required INTEGER NOT NULL DEFAULT 1,
    visible_required INTEGER NOT NULL DEFAULT 1,
    enabled_required INTEGER NOT NULL DEFAULT 0,
    expected_text TEXT,
    parent_component_key TEXT,
    metadata_json TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(screen_id, component_key),
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id)
);

-- 7. Functions Table
CREATE TABLE IF NOT EXISTS screen_functions (
    function_id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_id INTEGER NOT NULL,
    function_key TEXT NOT NULL,
    function_name TEXT NOT NULL,
    trigger_component_key TEXT,
    function_type TEXT NOT NULL,
    expected_result TEXT,
    validation_rule TEXT,
    business_rule_key TEXT,
    api_endpoint_key TEXT,
    database_validation_key TEXT,
    required INTEGER NOT NULL DEFAULT 1,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(screen_id, function_key),
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id)
);

-- 8. Business Rules Table
CREATE TABLE IF NOT EXISTS business_rules (
    business_rule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    rule_key TEXT NOT NULL UNIQUE,
    rule_name TEXT NOT NULL,
    module_name TEXT,
    description TEXT NOT NULL,
    input_definition_json TEXT,
    expected_logic_json TEXT,
    validation_expression TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- 9. API Endpoints Table
CREATE TABLE IF NOT EXISTS api_endpoints (
    endpoint_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    endpoint_key TEXT NOT NULL,
    endpoint_name TEXT NOT NULL,
    http_method TEXT NOT NULL,
    path TEXT NOT NULL,
    authentication_type TEXT,
    request_schema_path TEXT,
    response_schema_path TEXT,
    expected_status_codes TEXT,
    required_role TEXT,
    operation_type TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(application_id, endpoint_key),
    FOREIGN KEY(application_id) REFERENCES applications(application_id)
);

-- 10. API Test Cases Table
CREATE TABLE IF NOT EXISTS api_test_cases (
    api_test_case_id INTEGER PRIMARY KEY AUTOINCREMENT,
    endpoint_id INTEGER NOT NULL,
    test_case_key TEXT NOT NULL,
    test_case_name TEXT NOT NULL,
    test_type TEXT NOT NULL,
    request_headers_json TEXT,
    request_path_params_json TEXT,
    request_query_params_json TEXT,
    request_body_json TEXT,
    expected_status_code INTEGER,
    expected_response_json TEXT,
    expected_schema_path TEXT,
    expected_error_code TEXT,
    required INTEGER NOT NULL DEFAULT 1,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(endpoint_id, test_case_key),
    FOREIGN KEY(endpoint_id) REFERENCES api_endpoints(endpoint_id)
);

-- 11. Integration Mappings Table
CREATE TABLE IF NOT EXISTS integration_mappings (
    integration_id INTEGER PRIMARY KEY AUTOINCREMENT,
    screen_id INTEGER NOT NULL,
    function_id INTEGER,
    component_id INTEGER,
    endpoint_id INTEGER,
    request_mapping_json TEXT,
    response_mapping_json TEXT,
    expected_ui_change_json TEXT,
    expected_database_change_json TEXT,
    required INTEGER NOT NULL DEFAULT 1,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY(function_id) REFERENCES screen_functions(function_id),
    FOREIGN KEY(component_id) REFERENCES ui_components(component_id),
    FOREIGN KEY(endpoint_id) REFERENCES api_endpoints(endpoint_id)
);

-- 12. Database Validation Rules Table
CREATE TABLE IF NOT EXISTS database_validation_rules (
    database_validation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    validation_key TEXT NOT NULL UNIQUE,
    validation_name TEXT NOT NULL,
    database_name TEXT,
    table_name TEXT,
    validation_type TEXT NOT NULL,
    setup_sql TEXT,
    verification_sql TEXT NOT NULL,
    cleanup_sql TEXT,
    expected_result_json TEXT,
    parameters_json TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- 13. Roles Table
CREATE TABLE IF NOT EXISTS roles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_key TEXT NOT NULL UNIQUE,
    role_name TEXT NOT NULL,
    description TEXT,
    test_email TEXT,
    test_password TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- 14. Permissions Table
CREATE TABLE IF NOT EXISTS permissions (
    permission_id INTEGER PRIMARY KEY AUTOINCREMENT,
    permission_key TEXT NOT NULL UNIQUE,
    permission_name TEXT NOT NULL,
    resource_type TEXT NOT NULL,
    resource_key TEXT NOT NULL,
    action_name TEXT NOT NULL,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- 15. Role Permissions Table
CREATE TABLE IF NOT EXISTS role_permissions (
    role_permission_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_id INTEGER NOT NULL,
    permission_id INTEGER NOT NULL,
    allowed INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(role_id, permission_id),
    FOREIGN KEY(role_id) REFERENCES roles(role_id),
    FOREIGN KEY(permission_id) REFERENCES permissions(permission_id)
);

-- 16. Workflows Table
CREATE TABLE IF NOT EXISTS workflows (
    workflow_id INTEGER PRIMARY KEY AUTOINCREMENT,
    workflow_key TEXT NOT NULL UNIQUE,
    workflow_name TEXT NOT NULL,
    module_name TEXT,
    description TEXT,
    required_role TEXT,
    active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);

-- 17. Workflow Steps Table
CREATE TABLE IF NOT EXISTS workflow_steps (
    workflow_step_id INTEGER PRIMARY KEY AUTOINCREMENT,
    workflow_id INTEGER NOT NULL,
    step_order INTEGER NOT NULL,
    step_key TEXT NOT NULL,
    screen_key TEXT,
    function_key TEXT,
    endpoint_key TEXT,
    action_type TEXT NOT NULL,
    action_configuration_json TEXT,
    expected_result_json TEXT,
    continue_on_failure INTEGER NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    UNIQUE(workflow_id, step_order),
    FOREIGN KEY(workflow_id) REFERENCES workflows(workflow_id)
);

-- 18. Test Executions Table
CREATE TABLE IF NOT EXISTS test_executions (
    execution_id INTEGER PRIMARY KEY AUTOINCREMENT,
    execution_uuid TEXT NOT NULL UNIQUE,
    suite_name TEXT NOT NULL,
    environment TEXT,
    application_id INTEGER,
    started_at TEXT NOT NULL,
    completed_at TEXT,
    status TEXT NOT NULL,
    triggered_by TEXT,
    git_branch TEXT,
    git_commit TEXT,
    java_version TEXT,
    browser_name TEXT,
    browser_version TEXT,
    operating_system TEXT,
    total_tests INTEGER NOT NULL DEFAULT 0,
    passed_tests INTEGER NOT NULL DEFAULT 0,
    failed_tests INTEGER NOT NULL DEFAULT 0,
    skipped_tests INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(application_id) REFERENCES applications(application_id)
);

-- 19. Test Results Table
CREATE TABLE IF NOT EXISTS test_results (
    result_id INTEGER PRIMARY KEY AUTOINCREMENT,
    execution_id INTEGER NOT NULL,
    layer_id INTEGER NOT NULL,
    screen_id INTEGER,
    endpoint_id INTEGER,
    workflow_id INTEGER,
    test_class TEXT NOT NULL,
    test_method TEXT NOT NULL,
    test_case_key TEXT,
    status TEXT NOT NULL,
    started_at TEXT NOT NULL,
    completed_at TEXT,
    duration_ms INTEGER,
    expected_result TEXT,
    actual_result TEXT,
    error_type TEXT,
    error_message TEXT,
    stack_trace TEXT,
    retry_count INTEGER NOT NULL DEFAULT 0,
    blocked_by_result_id INTEGER,
    created_at TEXT NOT NULL,
    FOREIGN KEY(execution_id) REFERENCES test_executions(execution_id),
    FOREIGN KEY(layer_id) REFERENCES testing_layers(layer_id),
    FOREIGN KEY(screen_id) REFERENCES screens(screen_id),
    FOREIGN KEY(endpoint_id) REFERENCES api_endpoints(endpoint_id),
    FOREIGN KEY(workflow_id) REFERENCES workflows(workflow_id)
);

-- 20. Test Evidence Table
CREATE TABLE IF NOT EXISTS test_evidence (
    evidence_id INTEGER PRIMARY KEY AUTOINCREMENT,
    result_id INTEGER NOT NULL,
    evidence_type TEXT NOT NULL,
    evidence_name TEXT NOT NULL,
    file_path TEXT,
    content_text TEXT,
    content_json TEXT,
    checksum TEXT,
    created_at TEXT NOT NULL,
    FOREIGN KEY(result_id) REFERENCES test_results(result_id)
);

-- 21. Defects Table
CREATE TABLE IF NOT EXISTS defects (
    defect_id INTEGER PRIMARY KEY AUTOINCREMENT,
    defect_key TEXT NOT NULL UNIQUE,
    result_id INTEGER,
    layer_id INTEGER NOT NULL,
    screen_id INTEGER,
    endpoint_id INTEGER,
    workflow_id INTEGER,
    severity TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    reproduction_steps TEXT,
    expected_result TEXT,
    actual_result TEXT,
    status TEXT NOT NULL DEFAULT 'OPEN',
    assigned_to TEXT,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL,
    resolved_at TEXT,
    FOREIGN KEY(result_id) REFERENCES test_results(result_id)
);

-- 22. Verification Summary Table
CREATE TABLE IF NOT EXISTS verification_summary (
    verification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    screen_id INTEGER,
    endpoint_id INTEGER,
    workflow_id INTEGER,
    layer_id INTEGER NOT NULL,
    latest_result_id INTEGER,
    status TEXT NOT NULL,
    required_test_count INTEGER NOT NULL DEFAULT 0,
    passed_test_count INTEGER NOT NULL DEFAULT 0,
    failed_test_count INTEGER NOT NULL DEFAULT 0,
    blocked_test_count INTEGER NOT NULL DEFAULT 0,
    coverage_percent REAL NOT NULL DEFAULT 0,
    last_verified_at TEXT,
    updated_at TEXT NOT NULL,
    FOREIGN KEY(application_id) REFERENCES applications(application_id)
);

-- 23. Certification Records Table
CREATE TABLE IF NOT EXISTS certification_records (
    certification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id INTEGER NOT NULL,
    screen_id INTEGER,
    endpoint_id INTEGER,
    workflow_id INTEGER,
    certification_status TEXT NOT NULL,
    certified_execution_id INTEGER,
    certified_at TEXT,
    certification_notes TEXT,
    layer_summary_json TEXT,
    open_defect_count INTEGER NOT NULL DEFAULT 0,
    evidence_complete INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY(application_id) REFERENCES applications(application_id),
    FOREIGN KEY(certified_execution_id) REFERENCES test_executions(execution_id)
);

-- VIEWS DEFINITIONS

-- View 1: Latest test results
CREATE VIEW IF NOT EXISTS latest_test_results AS
SELECT tr.*
FROM test_results tr
JOIN (
    SELECT
        layer_id,
        COALESCE(screen_id, -1) AS screen_key,
        COALESCE(endpoint_id, -1) AS endpoint_key,
        COALESCE(workflow_id, -1) AS workflow_key,
        test_class,
        test_method,
        MAX(result_id) AS max_result_id
    FROM test_results
    GROUP BY
        layer_id,
        COALESCE(screen_id, -1),
        COALESCE(endpoint_id, -1),
        COALESCE(workflow_id, -1),
        test_class,
        test_method
) latest
ON tr.result_id = latest.max_result_id;

-- View 2: Screen layer status
CREATE VIEW IF NOT EXISTS screen_layer_status AS
SELECT 
    s.screen_key,
    s.route,
    tl.layer_code,
    lr.required,
    tr.result_id AS latest_result_id,
    COALESCE(tr.status, 'NOT_TESTED') AS status,
    tr.completed_at AS last_tested_date,
    (SELECT COUNT(*) FROM test_evidence te WHERE te.result_id = tr.result_id) AS evidence_count,
    (SELECT COUNT(*) FROM defects d WHERE d.screen_id = s.screen_id AND d.status = 'OPEN') AS open_defect_count
FROM screens s
CROSS JOIN testing_layers tl
LEFT JOIN screen_layer_requirements lr ON s.screen_id = lr.screen_id AND tl.layer_id = lr.layer_id
LEFT JOIN latest_test_results tr ON s.screen_id = tr.screen_id AND tl.layer_id = tr.layer_id;

-- View 3: Certification readiness
CREATE VIEW IF NOT EXISTS certification_readiness AS
SELECT 
    s.screen_id,
    s.screen_key,
    s.screen_name,
    COUNT(lr.requirement_id) AS total_required_layers,
    SUM(CASE WHEN COALESCE(tr.status, 'NOT_TESTED') = 'PASSED' THEN 1 ELSE 0 END) AS passed_required_layers,
    SUM(CASE WHEN COALESCE(tr.status, 'NOT_TESTED') = 'FAILED' THEN 1 ELSE 0 END) AS failed_required_layers,
    (SELECT COUNT(*) FROM defects d WHERE d.screen_id = s.screen_id AND d.status = 'OPEN') AS open_defects,
    CASE 
        WHEN COUNT(lr.requirement_id) = SUM(CASE WHEN COALESCE(tr.status, 'NOT_TESTED') = 'PASSED' THEN 1 ELSE 0 END) 
             AND (SELECT COUNT(*) FROM defects d WHERE d.screen_id = s.screen_id AND d.status = 'OPEN') = 0 
        THEN 'READY' 
        ELSE 'NOT_READY' 
    END AS readiness_status
FROM screens s
JOIN screen_layer_requirements lr ON s.screen_id = lr.screen_id
LEFT JOIN latest_test_results tr ON s.screen_id = tr.screen_id AND lr.layer_id = tr.layer_id
WHERE lr.required = 1
GROUP BY s.screen_id;
