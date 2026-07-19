-- Seed Data: V2__seed
-- Created: 2026-07-14

-- 1. Seed Applications
INSERT OR IGNORE INTO applications (application_id, application_key, application_name, base_url, api_base_url, environment, active, created_at, updated_at)
VALUES (1, 'primecare-core', 'PrimeCare Platform', 'http://localhost:8080', 'http://localhost:8080/api', 'dev', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 2. Seed Testing Layers
INSERT OR REPLACE INTO testing_layers (layer_id, layer_code, layer_name, layer_order, description, blocking, active) VALUES
(1, 'L1', 'Route and Navigation', 1, 'Verifies that screen routes are accessible and respond correctly', 1, 1),
(2, 'L2', 'UI Component Verification', 2, 'Verifies presence, visibility, enablement and semantics of UI elements', 1, 1),
(3, 'L3', 'Functional Behaviour', 3, 'Validates simple UI functional actions such as clicks and forms', 1, 1),
(4, 'L4', 'Business Logic', 4, 'Validates UI-level business calculations, validations and boundaries', 1, 1),
(5, 'L5', 'API Endpoint', 5, 'Tests backend REST endpoints directly with schema contract validation', 1, 1),
(6, 'L6', 'UI/API Integration', 6, 'Ensures UI events trigger correct API calls with appropriate payloads', 1, 1),
(7, 'L7', 'Database and Data Flow', 7, 'Verifies UI/API transactions are persisted and read correctly from the DB', 1, 1),
(8, 'L8', 'Security and RBAC', 8, 'Validates role-based access control and unauthorized API rejection', 1, 1),
(9, 'L9', 'End-to-End Workflow', 9, 'Validates multi-step, cross-module business flows with shared contexts', 1, 1),
(10, 'L10', 'Governance and Certification', 10, 'Computes total layer readiness, defect counts, and issues certifications', 1, 1);

-- 3. Seed Roles
INSERT OR IGNORE INTO roles (role_id, role_key, role_name, description, active, created_at, updated_at) VALUES
(1, 'ADMIN', 'Administrator', 'System Administrator with full access', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'CAREGIVER', 'Caregiver', 'Frontline clinical caregiver staff', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(3, 'CLIENT', 'Client', 'Patient or client portal user', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 4. Seed Screens
INSERT OR IGNORE INTO screens (screen_id, application_id, screen_key, screen_name, route, page_class, module_name, required_role, implementation_status, verification_status, active, created_at, updated_at) VALUES
(1, 1, 'language', 'Language Selection', '/language', 'primecare.testing.pages.LanguagePage', 'Core', 'ANY', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 1, 'login', 'Login Screen', '/login', 'primecare.testing.pages.LoginPage', 'Auth', 'ANY', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(3, 1, 'success', 'Dashboard Success', '/clinic/dashboard', 'primecare.testing.pages.SuccessPage', 'Dashboard', 'ANY', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(4, 1, 'invalid-route', 'Invalid Route Handler', '/invalid-test-path-for-404', 'primecare.testing.pages.ErrorPage', 'Core', 'ANY', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(5, 1, 'clinic-care-plan', 'Care Plan', '/clinic/care-plan', 'primecare.testing.pages.CarePlanPage', 'Clinic', 'ADMIN', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(6, 1, 'clinic-daily-notes', 'Daily Notes', '/clinic/daily-notes', 'primecare.testing.pages.DailyNotesPage', 'Clinic', 'ADMIN', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(7, 1, 'clinic-client-profile', 'Client Profile', '/clinic/client-profile', 'primecare.testing.pages.ClientProfilePage', 'Clinic', 'ADMIN', 'VERIFIED', 'NOT_TESTED', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 5. Seed Screen Layer Requirements (L1 - L10 required for Login)
INSERT OR IGNORE INTO screen_layer_requirements (screen_id, layer_id, required, dependency_layer_id, configuration_json, created_at, updated_at) VALUES
(2, 1, 1, NULL, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 2, 1, 1, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 3, 1, 2, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 4, 1, 3, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 5, 1, 4, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 6, 1, 5, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 7, 1, 6, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 8, 1, 7, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 9, 1, 8, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 10, 1, 9, '{}', '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 6. Seed UI Components (Login Page Elements)
INSERT OR IGNORE INTO ui_components (screen_id, component_key, component_name, component_type, locator_strategy, locator_value, data_cy, required, visible_required, enabled_required, expected_text, parent_component_key, metadata_json, active, created_at, updated_at) VALUES
(1, 'lang_english_button', 'English Selection Button', 'BUTTON', 'aria-label', 'lang-english', 'lang-english', 1, 1, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(1, 'lang_french_button', 'French Selection Button', 'BUTTON', 'aria-label', 'lang-french', 'lang-french', 1, 1, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'email_field', 'Email Input', 'TEXT_FIELD', 'aria-label', 'login-email', 'login-email', 1, 1, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'password_field', 'Password Input', 'PASSWORD_FIELD', 'aria-label', 'login-password', 'login-password', 1, 1, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'submit_button', 'Login Submit Button', 'BUTTON', 'aria-label', 'login-submit', 'login-submit', 1, 1, 1, 'LOGIN', NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'forgot_password_link', 'Forgot Password Link', 'LINK', 'aria-label', 'login-forgot-password', 'forgot-password-link', 1, 1, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(3, 'logout_button', 'Logout Button', 'BUTTON', 'aria-label', 'topbar-logout-button', 'topbar-logout-button', 1, 1, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(3, 'user_menu', 'User Menu Button', 'BUTTON', 'aria-label', 'topbar-user-menu', 'topbar-user-menu', 1, 0, 1, NULL, NULL, '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 7. Seed Screen Functions
INSERT OR IGNORE INTO screen_functions (screen_id, function_key, function_name, trigger_component_key, function_type, expected_result, validation_rule, business_rule_key, api_endpoint_key, database_validation_key, required, active, created_at, updated_at) VALUES
(2, 'submit_valid_login', 'Perform Valid Login', 'submit_button', 'SUBMIT', 'redirect to /success', 'URL_CONTAINS_/success', 'AUTH_VALIDATION', 'auth_login', 'user_session_exists', 1, 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 'submit_invalid_login', 'Perform Invalid Login', 'submit_button', 'SUBMIT', 'error message displayed', 'TEXT_EXISTS_Invalid credentials', 'AUTH_VALIDATION', 'auth_login', NULL, 1, 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 8. Seed Business Rules
INSERT OR IGNORE INTO business_rules (business_rule_id, rule_key, rule_name, module_name, description, input_definition_json, expected_logic_json, validation_expression, active, created_at, updated_at) VALUES
(1, 'AUTH_VALIDATION', 'Authentication Format Checks', 'Auth', 'Checks email is formatted and password meets minimum length criteria', '{"email":"string","password":"string"}', '{"email_format":"^[^@]+@[^@]+\\.[^@]+$","min_password_len":6}', 'email.matches(email_format) && password.length >= min_password_len', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 9. Seed API Endpoints
INSERT OR IGNORE INTO api_endpoints (endpoint_id, application_id, endpoint_key, endpoint_name, http_method, path, authentication_type, request_schema_path, response_schema_path, expected_status_codes, required_role, operation_type, active, created_at, updated_at) VALUES
(1, 1, 'auth_login', 'Authenticate User', 'POST', '/api/auth/login', 'NONE', 'schemas/login_request.json', 'schemas/login_response.json', '200,401', 'ANY', 'READ', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 10. Seed API Test Cases
INSERT OR IGNORE INTO api_test_cases (api_test_case_id, endpoint_id, test_case_key, test_case_name, test_type, request_headers_json, request_path_params_json, request_query_params_json, request_body_json, expected_status_code, expected_response_json, expected_schema_path, expected_error_code, required, active, created_at, updated_at) VALUES
(1, 1, 'login_success', 'Successful Authenticated Login', 'POSITIVE', '{"Content-Type":"application/json"}', '{}', '{}', '{"email":"clinic@primecare.com","password":"Password123"}', 200, '{"token":"dummy_jwt_token","user":{"id":1,"email":"clinic@primecare.com","role":"CLINIC"}}', 'schemas/login_response.json', NULL, 1, 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 1, 'login_unauthorized', 'Rejected Authentication Due To Invalid Credentials', 'NEGATIVE', '{"Content-Type":"application/json"}', '{}', '{}', '{"email":"clinic@primecare.com","password":"WrongPassword"}', 401, '{"error":"Unauthorized","message":"Invalid credentials"}', NULL, 'UNAUTHORIZED', 1, 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 11. Seed Database Validation Rules
INSERT OR IGNORE INTO database_validation_rules (database_validation_id, validation_key, validation_name, database_name, table_name, validation_type, setup_sql, verification_sql, cleanup_sql, expected_result_json, parameters_json, active, created_at, updated_at) VALUES
(1, 'user_session_exists', 'Check active test user session', 'governance.db', 'test_executions', 'QUERY_ROW_COUNT', NULL, 'SELECT COUNT(*) FROM test_executions WHERE status = ''RUNNING''', NULL, '{"count": 1}', '{}', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 11b. Seed Integration Mappings
INSERT OR IGNORE INTO integration_mappings (integration_id, screen_id, function_id, component_id, endpoint_id, request_mapping_json, response_mapping_json, expected_ui_change_json, expected_database_change_json, required, active, created_at, updated_at) VALUES
(1, 2, 2, 5, 1, '{}', '{}', '{}', '{}', 1, 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 12. Seed Workflows
INSERT OR IGNORE INTO workflows (workflow_id, workflow_key, workflow_name, module_name, description, required_role, active, created_at, updated_at) VALUES
(1, 'login_verification_flow', 'Language and Login Verification Workflow', 'Core', 'Selects default language and authenticates to system, landing on dashboard', 'ANY', 1, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');

-- 13. Seed Workflow Steps
INSERT OR IGNORE INTO workflow_steps (workflow_step_id, workflow_id, step_order, step_key, screen_key, function_key, endpoint_key, action_type, action_configuration_json, expected_result_json, continue_on_failure, created_at, updated_at) VALUES
(1, 1, 1, 'navigate_language', 'language', NULL, NULL, 'NAVIGATE', '{}', '{"current_url_contains":"/language"}', 0, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(2, 1, 2, 'navigate_login', 'login', NULL, NULL, 'NAVIGATE', '{}', '{"current_url_contains":"/login"}', 0, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z'),
(3, 1, 3, 'submit_login', 'login', 'submit_valid_login', NULL, 'EXECUTE_FUNCTION', '{"inputs":{"email":"clinic@primecare.com","password":"Password123"}}', '{"current_url_contains":"/dashboard"}', 0, '2026-07-14T00:00:00Z', '2026-07-14T00:00:00Z');
