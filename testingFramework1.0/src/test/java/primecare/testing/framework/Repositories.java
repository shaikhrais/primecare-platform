package primecare.testing.framework;

import static primecare.testing.framework.Models.*;

import primecare.testing.models.*;
import primecare.testing.base.BaseTest;

import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class Repositories {

    // 1. ApplicationRepository
    public static class ApplicationRepository {
        public static ApplicationDefinition getApplicationByKey(String key) {
            String sql = "SELECT * FROM applications WHERE application_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        ApplicationDefinition app = new ApplicationDefinition();
                        app.applicationId = rs.getInt("application_id");
                        app.applicationKey = rs.getString("application_key");
                        app.applicationName = rs.getString("application_name");
                        app.baseUrl = rs.getString("base_url");
                        app.apiBaseUrl = rs.getString("api_base_url");
                        app.environment = rs.getString("environment");
                        app.active = rs.getInt("active") == 1;
                        app.createdAt = rs.getString("created_at");
                        app.updatedAt = rs.getString("updated_at");
                        return app;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getApplicationByKey: " + e.getMessage());
            }
            return null;
        }

        public static ApplicationDefinition getApplicationById(int id) {
            String sql = "SELECT * FROM applications WHERE application_id = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, id);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        ApplicationDefinition app = new ApplicationDefinition();
                        app.applicationId = rs.getInt("application_id");
                        app.applicationKey = rs.getString("application_key");
                        app.applicationName = rs.getString("application_name");
                        app.baseUrl = rs.getString("base_url");
                        app.apiBaseUrl = rs.getString("api_base_url");
                        app.environment = rs.getString("environment");
                        app.active = rs.getInt("active") == 1;
                        app.createdAt = rs.getString("created_at");
                        app.updatedAt = rs.getString("updated_at");
                        return app;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getApplicationById: " + e.getMessage());
            }
            return null;
        }
    }

    // 2. ScreenRepository
    public static class ScreenRepository {
        public static ScreenDefinition getScreenByKey(String key) {
            String sql = "SELECT * FROM screens WHERE screen_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return mapScreen(rs);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getScreenByKey: " + e.getMessage());
            }
            return null;
        }

        public static List<ScreenDefinition> getScreens() {
            List<ScreenDefinition> list = new ArrayList<>();
            String sql = "SELECT * FROM screens WHERE active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    list.add(mapScreen(rs));
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getScreens: " + e.getMessage());
            }
            return list;
        }

        public static void updateScreenStatus(int screenId, String implStatus, String verStatus) {
            String sql = "UPDATE screens SET implementation_status = ?, verification_status = ?, updated_at = ? WHERE screen_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, implStatus);
                pstmt.setString(2, verStatus);
                pstmt.setString(3, Instant.now().toString());
                pstmt.setInt(4, screenId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in updateScreenStatus: " + e.getMessage());
            }
        }

        private static ScreenDefinition mapScreen(ResultSet rs) throws SQLException {
            ScreenDefinition s = new ScreenDefinition();
            s.screenId = rs.getInt("screen_id");
            s.applicationId = rs.getInt("application_id");
            s.screenKey = rs.getString("screen_key");
            s.screenName = rs.getString("screen_name");
            s.route = rs.getString("route");
            s.pageClass = rs.getString("page_class");
            s.moduleName = rs.getString("module_name");
            s.requiredRole = rs.getString("required_role");
            s.implementationStatus = rs.getString("implementation_status");
            s.verificationStatus = rs.getString("verification_status");
            s.active = rs.getInt("active") == 1;
            s.createdAt = rs.getString("created_at");
            s.updatedAt = rs.getString("updated_at");
            return s;
        }
    }

    // 3. TestingLayerRepository
    public static class TestingLayerRepository {
        public static List<TestingLayer> getTestingLayers() {
            List<TestingLayer> list = new ArrayList<>();
            String sql = "SELECT * FROM testing_layers WHERE active = 1 ORDER BY layer_order";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    TestingLayer layer = new TestingLayer();
                    layer.layerId = rs.getInt("layer_id");
                    layer.layerCode = rs.getString("layer_code");
                    layer.layerName = rs.getString("layer_name");
                    layer.layerOrder = rs.getInt("layer_order");
                    layer.description = rs.getString("description");
                    layer.blocking = rs.getInt("blocking") == 1;
                    layer.active = rs.getInt("active") == 1;
                    list.add(layer);
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getTestingLayers: " + e.getMessage());
            }
            return list;
        }
    }

    // 4. ComponentRepository
    public static class ComponentRepository {
        public static List<UiComponentDefinition> getComponentsForScreen(int screenId) {
            List<UiComponentDefinition> list = new ArrayList<>();
            String sql = "SELECT * FROM ui_components WHERE screen_id = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, screenId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        UiComponentDefinition c = new UiComponentDefinition();
                        c.componentId = rs.getInt("component_id");
                        c.screenId = rs.getInt("screen_id");
                        c.componentKey = rs.getString("component_key");
                        c.componentName = rs.getString("component_name");
                        c.componentType = rs.getString("component_type");
                        c.locatorStrategy = rs.getString("locator_strategy");
                        c.locatorValue = rs.getString("locator_value");
                        c.dataCy = rs.getString("data_cy");
                        c.required = rs.getInt("required") == 1;
                        c.visibleRequired = rs.getInt("visible_required") == 1;
                        c.enabledRequired = rs.getInt("enabled_required") == 1;
                        c.expectedText = rs.getString("expected_text");
                        c.parentComponentKey = rs.getString("parent_component_key");
                        c.metadataJson = rs.getString("metadata_json");
                        c.active = rs.getInt("active") == 1;
                        c.createdAt = rs.getString("created_at");
                        c.updatedAt = rs.getString("updated_at");
                        list.add(c);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getComponentsForScreen: " + e.getMessage());
            }
            return list;
        }
    }

    // 5. FunctionRepository
    public static class FunctionRepository {
        public static List<ScreenFunctionDefinition> getFunctionsForScreen(int screenId) {
            List<ScreenFunctionDefinition> list = new ArrayList<>();
            String sql = "SELECT * FROM screen_functions WHERE screen_id = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, screenId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        ScreenFunctionDefinition f = new ScreenFunctionDefinition();
                        f.functionId = rs.getInt("function_id");
                        f.screenId = rs.getInt("screen_id");
                        f.functionKey = rs.getString("function_key");
                        f.functionName = rs.getString("function_name");
                        f.triggerComponentKey = rs.getString("trigger_component_key");
                        f.functionType = rs.getString("function_type");
                        f.expectedResult = rs.getString("expected_result");
                        f.validationRule = rs.getString("validation_rule");
                        f.businessRuleKey = rs.getString("business_rule_key");
                        f.apiEndpointKey = rs.getString("api_endpoint_key");
                        f.databaseValidationKey = rs.getString("database_validation_key");
                        f.required = rs.getInt("required") == 1;
                        f.active = rs.getInt("active") == 1;
                        f.createdAt = rs.getString("created_at");
                        f.updatedAt = rs.getString("updated_at");
                        list.add(f);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getFunctionsForScreen: " + e.getMessage());
            }
            return list;
        }
    }

    // 6. BusinessRuleRepository
    public static class BusinessRuleRepository {
        public static BusinessRuleDefinition getBusinessRule(String key) {
            String sql = "SELECT * FROM business_rules WHERE rule_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        BusinessRuleDefinition r = new BusinessRuleDefinition();
                        r.businessRuleId = rs.getInt("business_rule_id");
                        r.ruleKey = rs.getString("rule_key");
                        r.ruleName = rs.getString("rule_name");
                        r.moduleName = rs.getString("module_name");
                        r.description = rs.getString("description");
                        r.inputDefinitionJson = rs.getString("input_definition_json");
                        r.expectedLogicJson = rs.getString("expected_logic_json");
                        r.validationExpression = rs.getString("validation_expression");
                        r.active = rs.getInt("active") == 1;
                        r.createdAt = rs.getString("created_at");
                        r.updatedAt = rs.getString("updated_at");
                        return r;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getBusinessRule: " + e.getMessage());
            }
            return null;
        }
    }

    // 7. ApiEndpointRepository
    public static class ApiEndpointRepository {
        public static ApiEndpointDefinition getEndpointByKey(String key) {
            String sql = "SELECT * FROM api_endpoints WHERE endpoint_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        ApiEndpointDefinition ed = new ApiEndpointDefinition();
                        ed.endpointId = rs.getInt("endpoint_id");
                        ed.applicationId = rs.getInt("application_id");
                        ed.endpointKey = rs.getString("endpoint_key");
                        ed.endpointName = rs.getString("endpoint_name");
                        ed.httpMethod = rs.getString("http_method");
                        ed.path = rs.getString("path");
                        ed.authenticationType = rs.getString("authentication_type");
                        ed.requestSchemaPath = rs.getString("request_schema_path");
                        ed.responseSchemaPath = rs.getString("response_schema_path");
                        ed.expectedStatusCodes = rs.getString("expected_status_codes");
                        ed.requiredRole = rs.getString("required_role");
                        ed.operationType = rs.getString("operation_type");
                        ed.active = rs.getInt("active") == 1;
                        ed.createdAt = rs.getString("created_at");
                        ed.updatedAt = rs.getString("updated_at");
                        return ed;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getEndpointByKey: " + e.getMessage());
            }
            return null;
        }
    }

    // 8. ApiTestCaseRepository
    public static class ApiTestCaseRepository {
        public static List<ApiTestCaseDefinition> getTestCasesForEndpoint(int endpointId) {
            List<ApiTestCaseDefinition> list = new ArrayList<>();
            String sql = "SELECT * FROM api_test_cases WHERE endpoint_id = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, endpointId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        ApiTestCaseDefinition tc = new ApiTestCaseDefinition();
                        tc.apiTestCaseId = rs.getInt("api_test_case_id");
                        tc.endpointId = rs.getInt("endpoint_id");
                        tc.testCaseKey = rs.getString("test_case_key");
                        tc.testCaseName = rs.getString("test_case_name");
                        tc.testType = rs.getString("test_type");
                        tc.requestHeadersJson = rs.getString("request_headers_json");
                        tc.requestPathParamsJson = rs.getString("request_path_params_json");
                        tc.requestQueryParamsJson = rs.getString("request_query_params_json");
                        tc.requestBodyJson = rs.getString("request_body_json");
                        tc.expectedStatusCode = rs.getInt("expected_status_code");
                        if (rs.wasNull()) tc.expectedStatusCode = null;
                        tc.expectedResponseJson = rs.getString("expected_response_json");
                        tc.expectedSchemaPath = rs.getString("expected_schema_path");
                        tc.expectedErrorCode = rs.getString("expected_error_code");
                        tc.required = rs.getInt("required") == 1;
                        tc.active = rs.getInt("active") == 1;
                        tc.createdAt = rs.getString("created_at");
                        tc.updatedAt = rs.getString("updated_at");
                        list.add(tc);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getTestCasesForEndpoint: " + e.getMessage());
            }
            return list;
        }
    }

    // 9. IntegrationRepository
    public static class IntegrationRepository {
        public static List<IntegrationMapping> getMappingsForScreen(int screenId) {
            List<IntegrationMapping> list = new ArrayList<>();
            String sql = "SELECT * FROM integration_mappings WHERE screen_id = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, screenId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        IntegrationMapping m = new IntegrationMapping();
                        m.integrationId = rs.getInt("integration_id");
                        m.screenId = rs.getInt("screen_id");
                        m.functionId = rs.getInt("function_id");
                        if (rs.wasNull()) m.functionId = null;
                        m.componentId = rs.getInt("component_id");
                        if (rs.wasNull()) m.componentId = null;
                        m.endpointId = rs.getInt("endpoint_id");
                        if (rs.wasNull()) m.endpointId = null;
                        m.requestMappingJson = rs.getString("request_mapping_json");
                        m.responseMappingJson = rs.getString("response_mapping_json");
                        m.expectedUiChangeJson = rs.getString("expected_ui_change_json");
                        m.expectedDatabaseChangeJson = rs.getString("expected_database_change_json");
                        m.required = rs.getInt("required") == 1;
                        m.active = rs.getInt("active") == 1;
                        m.createdAt = rs.getString("created_at");
                        m.updatedAt = rs.getString("updated_at");
                        list.add(m);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getMappingsForScreen: " + e.getMessage());
            }
            return list;
        }
    }

    // 10. DatabaseValidationRepository
    public static class DatabaseValidationRepository {
        public static DatabaseValidationRule getRuleByKey(String key) {
            String sql = "SELECT * FROM database_validation_rules WHERE validation_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        DatabaseValidationRule r = new DatabaseValidationRule();
                        r.databaseValidationId = rs.getInt("database_validation_id");
                        r.validationKey = rs.getString("validation_key");
                        r.validationName = rs.getString("validation_name");
                        r.databaseName = rs.getString("database_name");
                        r.tableName = rs.getString("table_name");
                        r.validationType = rs.getString("validation_type");
                        r.setupSql = rs.getString("setup_sql");
                        r.verificationSql = rs.getString("verification_sql");
                        r.cleanupSql = rs.getString("cleanup_sql");
                        r.expectedResultJson = rs.getString("expected_result_json");
                        r.parametersJson = rs.getString("parameters_json");
                        r.active = rs.getInt("active") == 1;
                        r.createdAt = rs.getString("created_at");
                        r.updatedAt = rs.getString("updated_at");
                        return r;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getRuleByKey: " + e.getMessage());
            }
            return null;
        }
    }

    // 11. RoleRepository
    public static class RoleRepository {
        public static RoleDefinition getRoleByKey(String key) {
            String sql = "SELECT * FROM roles WHERE role_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        RoleDefinition rd = new RoleDefinition();
                        rd.roleId = rs.getInt("role_id");
                        rd.roleKey = rs.getString("role_key");
                        rd.roleName = rs.getString("role_name");
                        rd.description = rs.getString("description");
                        rd.testEmail = rs.getString("test_email");
                        rd.testPassword = rs.getString("test_password");
                        rd.active = rs.getInt("active") == 1;
                        rd.createdAt = rs.getString("created_at");
                        rd.updatedAt = rs.getString("updated_at");
                        return rd;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getRoleByKey: " + e.getMessage());
            }
            return null;
        }
    }

    // 12. PermissionRepository
    public static class PermissionRepository {
        public static boolean isAllowed(String roleKey, String permissionKey) {
            String sql = "SELECT rp.allowed FROM role_permissions rp " +
                         "JOIN roles r ON r.role_id = rp.role_id " +
                         "JOIN permissions p ON p.permission_id = rp.permission_id " +
                         "WHERE r.role_key = ? AND p.permission_key = ? AND r.active = 1 AND p.active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, roleKey);
                pstmt.setString(2, permissionKey);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) == 1;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in isAllowed: " + e.getMessage());
            }
            return false;
        }
    }

    // 13. WorkflowRepository
    public static class WorkflowRepository {
        public static WorkflowDefinition getWorkflowByKey(String key) {
            String sql = "SELECT * FROM workflows WHERE workflow_key = ? AND active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, key);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        WorkflowDefinition w = new WorkflowDefinition();
                        w.workflowId = rs.getInt("workflow_id");
                        w.workflowKey = rs.getString("workflow_key");
                        w.workflowName = rs.getString("workflow_name");
                        w.moduleName = rs.getString("module_name");
                        w.description = rs.getString("description");
                        w.requiredRole = rs.getString("required_role");
                        w.active = rs.getInt("active") == 1;
                        w.createdAt = rs.getString("created_at");
                        w.updatedAt = rs.getString("updated_at");
                        return w;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getWorkflowByKey: " + e.getMessage());
            }
            return null;
        }

        public static List<WorkflowStepDefinition> getWorkflowSteps(int workflowId) {
            List<WorkflowStepDefinition> list = new ArrayList<>();
            String sql = "SELECT * FROM workflow_steps WHERE workflow_id = ? ORDER BY step_order";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, workflowId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        WorkflowStepDefinition ws = new WorkflowStepDefinition();
                        ws.workflowStepId = rs.getInt("workflow_step_id");
                        ws.workflowId = rs.getInt("workflow_id");
                        ws.stepOrder = rs.getInt("step_order");
                        ws.stepKey = rs.getString("step_key");
                        ws.screenKey = rs.getString("screen_key");
                        ws.functionKey = rs.getString("function_key");
                        ws.endpointKey = rs.getString("endpoint_key");
                        ws.actionType = rs.getString("action_type");
                        ws.actionConfigurationJson = rs.getString("action_configuration_json");
                        ws.expectedResultJson = rs.getString("expected_result_json");
                        ws.continueOnFailure = rs.getInt("continue_on_failure") == 1;
                        ws.createdAt = rs.getString("created_at");
                        ws.updatedAt = rs.getString("updated_at");
                        list.add(ws);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getWorkflowSteps: " + e.getMessage());
            }
            return list;
        }
    }

    // 14. ExecutionRepository
    public static class ExecutionRepository {
        public static void insertExecution(TestExecution exec) {
            String sql = "INSERT INTO test_executions (execution_uuid, suite_name, environment, application_id, started_at, status, triggered_by, git_branch, git_commit, java_version, browser_name, browser_version, operating_system) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, exec.executionUuid);
                pstmt.setString(2, exec.suiteName);
                pstmt.setString(3, exec.environment);
                if (exec.applicationId != null) pstmt.setInt(4, exec.applicationId);
                else pstmt.setNull(4, Types.INTEGER);
                pstmt.setString(5, exec.startedAt);
                pstmt.setString(6, exec.status);
                pstmt.setString(7, exec.triggeredBy);
                pstmt.setString(8, exec.gitBranch);
                pstmt.setString(9, exec.gitCommit);
                pstmt.setString(10, exec.javaVersion);
                pstmt.setString(11, exec.browserName);
                pstmt.setString(12, exec.browserVersion);
                pstmt.setString(13, exec.operatingSystem);
                pstmt.executeUpdate();

                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        exec.executionId = generatedKeys.getInt(1);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertExecution: " + e.getMessage());
            }
        }

        public static void updateExecution(TestExecution exec) {
            String sql = "UPDATE test_executions SET completed_at = ?, status = ?, total_tests = ?, passed_tests = ?, failed_tests = ?, skipped_tests = ? WHERE execution_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, exec.completedAt);
                pstmt.setString(2, exec.status);
                pstmt.setInt(3, exec.totalTests);
                pstmt.setInt(4, exec.passedTests);
                pstmt.setInt(5, exec.failedTests);
                pstmt.setInt(6, exec.skippedTests);
                pstmt.setInt(7, exec.executionId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in updateExecution: " + e.getMessage());
            }
        }
    }

    // 15. TestResultRepository
    public static class TestResultRepository {
        public static void insertResult(TestResult res) {
            String sql = "INSERT INTO test_results (execution_id, layer_id, screen_id, endpoint_id, workflow_id, test_class, test_method, test_case_key, status, started_at, completed_at, duration_ms, expected_result, actual_result, error_type, error_message, stack_trace, retry_count, blocked_by_result_id, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, res.executionId);
                pstmt.setInt(2, res.layerId);
                if (res.screenId != null) pstmt.setInt(3, res.screenId);
                else pstmt.setNull(3, Types.INTEGER);
                if (res.endpointId != null) pstmt.setInt(4, res.endpointId);
                else pstmt.setNull(4, Types.INTEGER);
                if (res.workflowId != null) pstmt.setInt(5, res.workflowId);
                else pstmt.setNull(5, Types.INTEGER);
                pstmt.setString(6, res.testClass);
                pstmt.setString(7, res.testMethod);
                pstmt.setString(8, res.testCaseKey);
                pstmt.setString(9, res.status);
                pstmt.setString(10, res.startedAt);
                pstmt.setString(11, res.completedAt);
                pstmt.setInt(12, res.durationMs);
                pstmt.setString(13, res.expectedResult);
                pstmt.setString(14, res.actualResult);
                pstmt.setString(15, res.errorType);
                pstmt.setString(16, res.errorMessage);
                pstmt.setString(17, res.stackTrace);
                pstmt.setInt(18, res.retryCount);
                if (res.blockedByResultId != null) pstmt.setInt(19, res.blockedByResultId);
                else pstmt.setNull(19, Types.INTEGER);
                pstmt.setString(20, Instant.now().toString());
                pstmt.executeUpdate();

                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        res.resultId = generatedKeys.getInt(1);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertResult: " + e.getMessage());
            }
        }

        public static void updateResult(TestResult res) {
            String sql = "UPDATE test_results SET status = ?, completed_at = ?, duration_ms = ?, expected_result = ?, actual_result = ?, error_type = ?, error_message = ?, stack_trace = ?, retry_count = ?, blocked_by_result_id = ? WHERE result_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, res.status);
                pstmt.setString(2, res.completedAt);
                pstmt.setInt(3, res.durationMs);
                pstmt.setString(4, res.expectedResult);
                pstmt.setString(5, res.actualResult);
                pstmt.setString(6, res.errorType);
                pstmt.setString(7, res.errorMessage);
                pstmt.setString(8, res.stackTrace);
                pstmt.setInt(9, res.retryCount);
                if (res.blockedByResultId != null) pstmt.setInt(10, res.blockedByResultId);
                else pstmt.setNull(10, Types.INTEGER);
                pstmt.setInt(11, res.resultId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in updateResult: " + e.getMessage());
            }
        }
    }

    // 16. EvidenceRepository
    public static class EvidenceRepository {
        public static void insertEvidence(TestEvidence ev) {
            String sql = "INSERT INTO test_evidence (result_id, evidence_type, evidence_name, file_path, content_text, content_json, checksum, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, ev.resultId);
                pstmt.setString(2, ev.evidenceType);
                pstmt.setString(3, ev.evidenceName);
                pstmt.setString(4, ev.filePath);
                pstmt.setString(5, ev.contentText);
                pstmt.setString(6, ev.contentJson);
                pstmt.setString(7, ev.checksum);
                pstmt.setString(8, Instant.now().toString());
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertEvidence: " + e.getMessage());
            }
        }
    }

    // 17. DefectRepository
    public static class DefectRepository {
        public static boolean hasOpenDefectFor(int layerId, Integer screenId, Integer endpointId, Integer workflowId, String testCaseKey, String errorType) {
            String sql = "SELECT COUNT(*) FROM defects WHERE layer_id = ? AND status = 'OPEN' " +
                         "AND (screen_id = ? OR (? IS NULL AND screen_id IS NULL)) " +
                         "AND (endpoint_id = ? OR (? IS NULL AND endpoint_id IS NULL)) " +
                         "AND (workflow_id = ? OR (? IS NULL AND workflow_id IS NULL)) " +
                         "AND (defect_key = ?)";
            
            // Defect key template: layer + screen/endpoint/workflow + test_case_key + error_type
            String ref = screenId != null ? "screen_" + screenId : (endpointId != null ? "endpoint_" + endpointId : "workflow_" + workflowId);
            String defectKey = "DEF_" + layerId + "_" + ref + "_" + testCaseKey + "_" + errorType;

            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, layerId);
                if (screenId != null) {
                    pstmt.setInt(2, screenId);
                    pstmt.setInt(3, screenId);
                } else {
                    pstmt.setNull(2, Types.INTEGER);
                    pstmt.setNull(3, Types.INTEGER);
                }
                if (endpointId != null) {
                    pstmt.setInt(4, endpointId);
                    pstmt.setInt(5, endpointId);
                } else {
                    pstmt.setNull(4, Types.INTEGER);
                    pstmt.setNull(5, Types.INTEGER);
                }
                if (workflowId != null) {
                    pstmt.setInt(6, workflowId);
                    pstmt.setInt(7, workflowId);
                } else {
                    pstmt.setNull(6, Types.INTEGER);
                    pstmt.setNull(7, Types.INTEGER);
                }
                pstmt.setString(8, defectKey);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1) > 0;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in hasOpenDefectFor: " + e.getMessage());
            }
            return false;
        }

        public static void insertDefect(Defect df) {
            String sql = "INSERT INTO defects (defect_key, result_id, layer_id, screen_id, endpoint_id, workflow_id, severity, title, description, reproduction_steps, expected_result, actual_result, status, assigned_to, created_at, updated_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, df.defectKey);
                if (df.resultId != null) pstmt.setInt(2, df.resultId);
                else pstmt.setNull(2, Types.INTEGER);
                pstmt.setInt(3, df.layerId);
                if (df.screenId != null) pstmt.setInt(4, df.screenId);
                else pstmt.setNull(4, Types.INTEGER);
                if (df.endpointId != null) pstmt.setInt(5, df.endpointId);
                else pstmt.setNull(5, Types.INTEGER);
                if (df.workflowId != null) pstmt.setInt(6, df.workflowId);
                else pstmt.setNull(6, Types.INTEGER);
                pstmt.setString(7, df.severity);
                pstmt.setString(8, df.title);
                pstmt.setString(9, df.description);
                pstmt.setString(10, df.reproductionSteps);
                pstmt.setString(11, df.expectedResult);
                pstmt.setString(12, df.actualResult);
                pstmt.setString(13, df.status);
                pstmt.setString(14, df.assignedTo);
                pstmt.setString(15, Instant.now().toString());
                pstmt.setString(16, Instant.now().toString());
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertDefect: " + e.getMessage());
            }
        }

        public static void resolveDefects(int layerId, Integer screenId, Integer endpointId, Integer workflowId, String testCaseKey) {
            String sql = "UPDATE defects SET status = 'RESOLVED', resolved_at = ?, updated_at = ? WHERE status = 'OPEN' AND layer_id = ? " +
                         "AND (screen_id = ? OR (? IS NULL AND screen_id IS NULL)) " +
                         "AND (endpoint_id = ? OR (? IS NULL AND endpoint_id IS NULL)) " +
                         "AND (workflow_id = ? OR (? IS NULL AND workflow_id IS NULL))";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, Instant.now().toString());
                pstmt.setString(2, Instant.now().toString());
                pstmt.setInt(3, layerId);
                if (screenId != null) {
                    pstmt.setInt(4, screenId);
                    pstmt.setInt(5, screenId);
                } else {
                    pstmt.setNull(4, Types.INTEGER);
                    pstmt.setNull(5, Types.INTEGER);
                }
                if (endpointId != null) {
                    pstmt.setInt(6, endpointId);
                    pstmt.setInt(7, endpointId);
                } else {
                    pstmt.setNull(6, Types.INTEGER);
                    pstmt.setNull(7, Types.INTEGER);
                }
                if (workflowId != null) {
                    pstmt.setInt(8, workflowId);
                    pstmt.setInt(9, workflowId);
                } else {
                    pstmt.setNull(8, Types.INTEGER);
                    pstmt.setNull(9, Types.INTEGER);
                }
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in resolveDefects: " + e.getMessage());
            }
        }
    }

    // 18. VerificationRepository
    public static class VerificationRepository {
        public static void insertOrUpdateSummary(VerificationSummary sum) {
            String checkSql = "SELECT verification_id FROM verification_summary WHERE application_id = ? AND layer_id = ? " +
                              "AND (screen_id = ? OR (? IS NULL AND screen_id IS NULL)) " +
                              "AND (endpoint_id = ? OR (? IS NULL AND endpoint_id IS NULL)) " +
                              "AND (workflow_id = ? OR (? IS NULL AND workflow_id IS NULL))";
            
            String insertSql = "INSERT INTO verification_summary (application_id, screen_id, endpoint_id, workflow_id, layer_id, latest_result_id, status, required_test_count, passed_test_count, failed_test_count, blocked_test_count, coverage_percent, last_verified_at, updated_at) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            String updateSql = "UPDATE verification_summary SET latest_result_id = ?, status = ?, required_test_count = ?, passed_test_count = ?, failed_test_count = ?, blocked_test_count = ?, coverage_percent = ?, last_verified_at = ?, updated_at = ? WHERE verification_id = ?";

            try (Connection conn = SQLiteConnectionManager.getConnection()) {
                Integer existingId = null;
                try (PreparedStatement pstmt = conn.prepareStatement(checkSql)) {
                    pstmt.setInt(1, sum.applicationId);
                    pstmt.setInt(2, sum.layerId);
                    if (sum.screenId != null) {
                        pstmt.setInt(3, sum.screenId);
                        pstmt.setInt(4, sum.screenId);
                    } else {
                        pstmt.setNull(3, Types.INTEGER);
                        pstmt.setNull(4, Types.INTEGER);
                    }
                    if (sum.endpointId != null) {
                        pstmt.setInt(5, sum.endpointId);
                        pstmt.setInt(6, sum.endpointId);
                    } else {
                        pstmt.setNull(5, Types.INTEGER);
                        pstmt.setNull(6, Types.INTEGER);
                    }
                    if (sum.workflowId != null) {
                        pstmt.setInt(7, sum.workflowId);
                        pstmt.setInt(8, sum.workflowId);
                    } else {
                        pstmt.setNull(7, Types.INTEGER);
                        pstmt.setNull(8, Types.INTEGER);
                    }

                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            existingId = rs.getInt(1);
                        }
                    }
                }

                if (existingId == null) {
                    try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                        pstmt.setInt(1, sum.applicationId);
                        if (sum.screenId != null) pstmt.setInt(2, sum.screenId);
                        else pstmt.setNull(2, Types.INTEGER);
                        if (sum.endpointId != null) pstmt.setInt(3, sum.endpointId);
                        else pstmt.setNull(3, Types.INTEGER);
                        if (sum.workflowId != null) pstmt.setInt(4, sum.workflowId);
                        else pstmt.setNull(4, Types.INTEGER);
                        pstmt.setInt(5, sum.layerId);
                        if (sum.latestResultId != null) pstmt.setInt(6, sum.latestResultId);
                        else pstmt.setNull(6, Types.INTEGER);
                        pstmt.setString(7, sum.status);
                        pstmt.setInt(8, sum.requiredTestCount);
                        pstmt.setInt(9, sum.passedTestCount);
                        pstmt.setInt(10, sum.failedTestCount);
                        pstmt.setInt(11, sum.blockedTestCount);
                        pstmt.setDouble(12, sum.coveragePercent);
                        pstmt.setString(13, sum.lastVerifiedAt);
                        pstmt.setString(14, Instant.now().toString());
                        pstmt.executeUpdate();
                    }
                } else {
                    try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                        if (sum.latestResultId != null) pstmt.setInt(1, sum.latestResultId);
                        else pstmt.setNull(1, Types.INTEGER);
                        pstmt.setString(2, sum.status);
                        pstmt.setInt(3, sum.requiredTestCount);
                        pstmt.setInt(4, sum.passedTestCount);
                        pstmt.setInt(5, sum.failedTestCount);
                        pstmt.setInt(6, sum.blockedTestCount);
                        pstmt.setDouble(7, sum.coveragePercent);
                        pstmt.setString(8, sum.lastVerifiedAt);
                        pstmt.setString(9, Instant.now().toString());
                        pstmt.setInt(10, existingId);
                        pstmt.executeUpdate();
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertOrUpdateSummary: " + e.getMessage());
            }
        }
    }

    // 19. CertificationRepository
    public static class CertificationRepository {
        public static void insertCertification(CertificationRecord cert) {
            String sql = "INSERT INTO certification_records (application_id, screen_id, endpoint_id, workflow_id, certification_status, certified_execution_id, certified_at, certification_notes, layer_summary_json, open_defect_count, evidence_complete) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, cert.applicationId);
                if (cert.screenId != null) pstmt.setInt(2, cert.screenId);
                else pstmt.setNull(2, Types.INTEGER);
                if (cert.endpointId != null) pstmt.setInt(3, cert.endpointId);
                else pstmt.setNull(3, Types.INTEGER);
                if (cert.workflowId != null) pstmt.setInt(4, cert.workflowId);
                else pstmt.setNull(4, Types.INTEGER);
                pstmt.setString(5, cert.certificationStatus);
                if (cert.certifiedExecutionId != null) pstmt.setInt(6, cert.certifiedExecutionId);
                else pstmt.setNull(6, Types.INTEGER);
                pstmt.setString(7, cert.certifiedAt);
                pstmt.setString(8, cert.certificationNotes);
                pstmt.setString(9, cert.layerSummaryJson);
                pstmt.setInt(10, cert.openDefectCount);
                pstmt.setInt(11, cert.evidenceComplete ? 1 : 0);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertCertification: " + e.getMessage());
            }
        }
    }

    // 20. TestPlanRepository
    public static class TestPlanRepository {
        public static void insertPlan(TestPlan plan) {
            String sql = "INSERT INTO test_execution_plans (plan_uuid, execution_id, application_id, requested_screen_key, requested_screen_id, requested_module, requested_level, requested_from_level, requested_to_level, requested_layers, execution_mode, include_dependencies, stop_on_failure, continue_on_failure, role_key, environment, created_at, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setString(1, plan.planUuid);
                if (BaseTest.executionId != -1) pstmt.setInt(2, BaseTest.executionId);
                else pstmt.setNull(2, Types.INTEGER);
                pstmt.setInt(3, 1); // Application ID
                pstmt.setString(4, plan.request.screenKey);
                if (plan.request.screenId != null) pstmt.setLong(5, plan.request.screenId);
                else pstmt.setNull(5, Types.INTEGER);
                pstmt.setString(6, plan.request.moduleName);
                if (plan.request.level != null) pstmt.setInt(7, plan.request.level);
                else pstmt.setNull(7, Types.INTEGER);
                if (plan.request.fromLevel != null) pstmt.setInt(8, plan.request.fromLevel);
                else pstmt.setNull(8, Types.INTEGER);
                if (plan.request.toLevel != null) pstmt.setInt(9, plan.request.toLevel);
                else pstmt.setNull(9, Types.INTEGER);
                
                String layers = "";
                if (plan.request.selectedLayers != null) {
                    StringBuilder sb = new StringBuilder();
                    for (TestingLayerCode c : plan.request.selectedLayers) {
                        if (sb.length() > 0) sb.append(",");
                        sb.append(c.name());
                    }
                    layers = sb.toString();
                }
                pstmt.setString(10, layers);
                pstmt.setString(11, plan.request.executionMode.name());
                pstmt.setInt(12, plan.request.includeDependencies ? 1 : 0);
                pstmt.setInt(13, plan.request.stopOnFailure ? 1 : 0);
                pstmt.setInt(14, plan.request.continueOnFailure ? 1 : 0);
                pstmt.setString(15, plan.request.roleKey);
                pstmt.setString(16, plan.request.environment);
                pstmt.setString(17, plan.createdAt.toString());
                pstmt.setString(18, "PLANNED");
                pstmt.executeUpdate();

                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        plan.planId = generatedKeys.getInt(1);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertPlan: " + e.getMessage());
            }
        }
    }

    // 21. TestPlanItemRepository
    public static class TestPlanItemRepository {
        public static void insertPlanItem(TestPlanItem item) {
            String sql = "INSERT INTO test_execution_plan_items (plan_id, plan_item_uuid, screen_id, layer_id, execution_order, required, applicable, skip_reason, status, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                pstmt.setInt(1, item.planId);
                pstmt.setString(2, item.planItemUuid);
                pstmt.setInt(3, item.screenId);
                pstmt.setInt(4, item.layerCode.ordinal() + 1);
                pstmt.setInt(5, item.executionOrder);
                pstmt.setInt(6, item.required ? 1 : 0);
                pstmt.setInt(7, item.applicable ? 1 : 0);
                pstmt.setString(8, item.skipReason);
                pstmt.setString(9, item.status.name());
                pstmt.setString(10, Instant.now().toString());
                pstmt.executeUpdate();

                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        item.planItemId = generatedKeys.getInt(1);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertPlanItem: " + e.getMessage());
            }
        }

        public static void updateItemStatus(int itemId, String status, Integer resultId) {
            String sql = "UPDATE test_execution_plan_items SET status = ?, result_id = ?, completed_at = ? WHERE plan_item_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, status);
                if (resultId != null) pstmt.setInt(2, resultId);
                else pstmt.setNull(2, Types.INTEGER);
                pstmt.setString(3, Instant.now().toString());
                pstmt.setInt(4, itemId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in updateItemStatus: " + e.getMessage());
            }
        }
    }

    // 22. ScreenTestCaseRepository
    public static class ScreenTestCaseRepository {
        public static void insertOrUpdateTestCase(ScreenTestCaseDefinition tc) {
            String checkSql = "SELECT screen_test_case_id FROM screen_test_cases WHERE screen_id = ? AND test_case_key = ?";
            String insertSql = "INSERT INTO screen_test_cases (screen_id, layer_id, test_case_key, test_case_name, test_class, test_method, source_type, execution_order, required, active, dependency_test_case_keys, tags, description, created_at, updated_at) " +
                               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 1, ?, ?, ?, ?, ?)";
            String updateSql = "UPDATE screen_test_cases SET test_case_name = ?, test_class = ?, test_method = ?, source_type = ?, execution_order = ?, required = ?, active = 1, dependency_test_case_keys = ?, tags = ?, description = ?, updated_at = ? WHERE screen_test_case_id = ?";
            
            int screenId = getScreenIdByKey(tc.screenKey);
            if (screenId == -1) {
                System.err.println("[DB] Screen not found for key: " + tc.screenKey);
                return;
            }

            try (Connection conn = SQLiteConnectionManager.getConnection()) {
                int existingId = -1;
                try (PreparedStatement pstmt = conn.prepareStatement(checkSql)) {
                    pstmt.setInt(1, screenId);
                    pstmt.setString(2, tc.testCaseKey);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            existingId = rs.getInt(1);
                        }
                    }
                }

                String now = Instant.now().toString();
                String depKeys = "";
                if (tc.dependencies != null) {
                    StringBuilder sb = new StringBuilder();
                    for (TestingLayerCode code : tc.dependencies) {
                        if (sb.length() > 0) sb.append(",");
                        sb.append(code.name());
                    }
                    depKeys = sb.toString();
                }

                if (existingId == -1) {
                    try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                        pstmt.setInt(1, screenId);
                        pstmt.setInt(2, tc.layerCode.ordinal() + 1);
                        pstmt.setString(3, tc.testCaseKey);
                        pstmt.setString(4, tc.testName);
                        pstmt.setString(5, tc.testClass);
                        pstmt.setString(6, tc.testMethod);
                        pstmt.setString(7, tc.source.name());
                        pstmt.setInt(8, tc.executionOrder);
                        pstmt.setInt(9, tc.required ? 1 : 0);
                        pstmt.setString(10, depKeys);
                        pstmt.setString(11, tc.tags);
                        pstmt.setString(12, tc.description);
                        pstmt.setString(13, now);
                        pstmt.setString(14, now);
                        pstmt.executeUpdate();
                    }
                } else {
                    try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                        pstmt.setString(1, tc.testName);
                        pstmt.setString(2, tc.testClass);
                        pstmt.setString(3, tc.testMethod);
                        pstmt.setString(4, tc.source.name());
                        pstmt.setInt(5, tc.executionOrder);
                        pstmt.setInt(6, tc.required ? 1 : 0);
                        pstmt.setString(7, depKeys);
                        pstmt.setString(8, tc.tags);
                        pstmt.setString(9, tc.description);
                        pstmt.setString(10, now);
                        pstmt.setInt(11, existingId);
                        pstmt.executeUpdate();
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertOrUpdateTestCase: " + e.getMessage());
            }
        }

        public static void markAllTestCasesInactive(int screenId) {
            String sql = "UPDATE screen_test_cases SET active = 0 WHERE screen_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, screenId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in markAllTestCasesInactive: " + e.getMessage());
            }
        }

        private static int getScreenIdByKey(String screenKey) {
            String sql = "SELECT screen_id FROM screens WHERE screen_key = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, screenKey);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            } catch (Exception e) {
                // Ignore
            }
            return -1;
        }

        public static List<ScreenTestCaseDefinition> getTestCasesForScreenAndLayer(int screenId, int layerId) {
            List<ScreenTestCaseDefinition> list = new ArrayList<>();
            String sql = "SELECT stc.*, s.screen_key FROM screen_test_cases stc " +
                         "JOIN screens s ON s.screen_id = stc.screen_id " +
                         "WHERE stc.screen_id = ? AND stc.layer_id = ? AND stc.active = 1";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, screenId);
                pstmt.setInt(2, layerId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        ScreenTestCaseDefinition tc = new ScreenTestCaseDefinition();
                        tc.testCaseKey = rs.getString("test_case_key");
                        tc.testName = rs.getString("test_case_name");
                        tc.screenKey = rs.getString("screen_key");
                        tc.layerCode = TestingLayerCode.values()[rs.getInt("layer_id") - 1];
                        tc.executionOrder = rs.getInt("execution_order");
                        tc.required = rs.getInt("required") == 1;
                        tc.source = TestCaseSource.valueOf(rs.getString("source_type"));
                        tc.testClass = rs.getString("test_class");
                        tc.testMethod = rs.getString("test_method");
                        tc.tags = rs.getString("tags");
                        tc.description = rs.getString("description");
                        list.add(tc);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getTestCasesForScreenAndLayer: " + e.getMessage());
            }
            return list;
        }
    }

    // 17. IssueRepository
    public static class IssueRepository {
        public static void insertIssue(Issue issue) {
            String sql = "INSERT OR REPLACE INTO issues (issue_id, project_id, title, description, category, severity, priority, status, environment, deployment_id, screen_id, route, component_id, test_id, first_test_run_id, latest_test_run_id, suspected_root_cause, confirmed_root_cause, affected_module, reproduction_steps, expected_result, actual_result, failure_message, failure_signature, failure_hash, assigned_agent, created_at, updated_at, resolved_at, closed_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, issue.issueId);
                pstmt.setString(2, issue.projectId);
                pstmt.setString(3, issue.title);
                pstmt.setString(4, issue.description);
                pstmt.setString(5, issue.category);
                pstmt.setString(6, issue.severity);
                if (issue.priority != null) pstmt.setInt(7, issue.priority);
                else pstmt.setNull(7, Types.INTEGER);
                pstmt.setString(8, issue.status);
                pstmt.setString(9, issue.environment);
                pstmt.setString(10, issue.deploymentId);
                pstmt.setString(11, issue.screenId);
                pstmt.setString(12, issue.route);
                pstmt.setString(13, issue.componentId);
                pstmt.setString(14, issue.testId);
                pstmt.setString(15, issue.firstTestRunId);
                pstmt.setString(16, issue.latestTestRunId);
                pstmt.setString(17, issue.suspectedRootCause);
                pstmt.setString(18, issue.confirmedRootCause);
                pstmt.setString(19, issue.affectedModule);
                pstmt.setString(20, issue.reproductionSteps);
                pstmt.setString(21, issue.expectedResult);
                pstmt.setString(22, issue.actualResult);
                pstmt.setString(23, issue.failureMessage);
                pstmt.setString(24, issue.failureSignature);
                pstmt.setString(25, issue.failureHash);
                pstmt.setString(26, issue.assignedAgent);
                pstmt.setString(27, issue.createdAt);
                pstmt.setString(28, issue.updatedAt);
                pstmt.setString(29, issue.resolvedAt);
                pstmt.setString(30, issue.closedAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertIssue: " + e.getMessage());
            }
        }

        public static void updateIssue(Issue issue) {
            String sql = "UPDATE issues SET status = ?, latest_test_run_id = ?, suspected_root_cause = ?, confirmed_root_cause = ?, updated_at = ?, resolved_at = ?, closed_at = ? WHERE issue_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, issue.status);
                pstmt.setString(2, issue.latestTestRunId);
                pstmt.setString(3, issue.suspectedRootCause);
                pstmt.setString(4, issue.confirmedRootCause);
                pstmt.setString(5, issue.updatedAt);
                pstmt.setString(6, issue.resolvedAt);
                pstmt.setString(7, issue.closedAt);
                pstmt.setString(8, issue.issueId);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in updateIssue: " + e.getMessage());
            }
        }

        public static Issue getIssueByHash(String hash) {
            String sql = "SELECT * FROM issues WHERE failure_hash = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, hash);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        Issue issue = new Issue();
                        issue.issueId = rs.getString("issue_id");
                        issue.projectId = rs.getString("project_id");
                        issue.title = rs.getString("title");
                        issue.description = rs.getString("description");
                        issue.category = rs.getString("category");
                        issue.severity = rs.getString("severity");
                        issue.status = rs.getString("status");
                        issue.environment = rs.getString("environment");
                        issue.deploymentId = rs.getString("deployment_id");
                        issue.screenId = rs.getString("screen_id");
                        issue.route = rs.getString("route");
                        issue.componentId = rs.getString("component_id");
                        issue.testId = rs.getString("test_id");
                        issue.firstTestRunId = rs.getString("first_test_run_id");
                        issue.latestTestRunId = rs.getString("latest_test_run_id");
                        issue.suspectedRootCause = rs.getString("suspected_root_cause");
                        issue.confirmedRootCause = rs.getString("confirmed_root_cause");
                        issue.affectedModule = rs.getString("affected_module");
                        issue.reproductionSteps = rs.getString("reproduction_steps");
                        issue.expectedResult = rs.getString("expected_result");
                        issue.actualResult = rs.getString("actual_result");
                        issue.failureMessage = rs.getString("failure_message");
                        issue.failureSignature = rs.getString("failure_signature");
                        issue.failureHash = rs.getString("failure_hash");
                        issue.assignedAgent = rs.getString("assigned_agent");
                        issue.createdAt = rs.getString("created_at");
                        issue.updatedAt = rs.getString("updated_at");
                        issue.resolvedAt = rs.getString("resolved_at");
                        issue.closedAt = rs.getString("closed_at");
                        return issue;
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getIssueByHash: " + e.getMessage());
            }
            return null;
        }

        public static void insertOccurrence(IssueOccurrence occ) {
            String sql = "INSERT OR REPLACE INTO issue_occurrences (occurrence_id, issue_id, test_run_id, deployment_id, screen_id, route, current_url, page_title, screen_identifier, http_status, screenshot_id, console_error_count, network_error_count, occurred_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, occ.occurrenceId);
                pstmt.setString(2, occ.issueId);
                pstmt.setString(3, occ.testRunId);
                pstmt.setString(4, occ.deploymentId);
                pstmt.setString(5, occ.screenId);
                pstmt.setString(6, occ.route);
                pstmt.setString(7, occ.currentUrl);
                pstmt.setString(8, occ.pageTitle);
                pstmt.setString(9, occ.screenIdentifier);
                if (occ.httpStatus != null) pstmt.setInt(10, occ.httpStatus);
                else pstmt.setNull(10, Types.INTEGER);
                pstmt.setString(11, occ.screenshotId);
                if (occ.consoleErrorCount != null) pstmt.setInt(12, occ.consoleErrorCount);
                else pstmt.setNull(12, Types.INTEGER);
                if (occ.networkErrorCount != null) pstmt.setInt(13, occ.networkErrorCount);
                else pstmt.setNull(13, Types.INTEGER);
                pstmt.setString(14, occ.occurredAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertOccurrence: " + e.getMessage());
            }
        }

        public static void insertStatusHistory(IssueStatusHistory history) {
            String sql = "INSERT OR REPLACE INTO issue_status_history (history_id, issue_id, previous_status, new_status, reason, changed_by, deployment_id, test_run_id, changed_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, history.historyId);
                pstmt.setString(2, history.issueId);
                pstmt.setString(3, history.previousStatus);
                pstmt.setString(4, history.newStatus);
                pstmt.setString(5, history.reason);
                pstmt.setString(6, history.changedBy);
                pstmt.setString(7, history.deploymentId);
                pstmt.setString(8, history.testRunId);
                pstmt.setString(9, history.changedAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertStatusHistory: " + e.getMessage());
            }
        }

        public static void insertFixAttempt(FixAttempt attempt) {
            String sql = "INSERT OR REPLACE INTO fix_attempts (fix_attempt_id, issue_id, attempt_number, description, suspected_fix, files_changed, code_change_summary, commit_id, build_id, deployment_id, retest_run_id, result, failure_reason, started_at, completed_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, attempt.fixAttemptId);
                pstmt.setString(2, attempt.issueId);
                pstmt.setInt(3, attempt.attemptNumber);
                pstmt.setString(4, attempt.description);
                pstmt.setString(5, attempt.suspectedFix);
                pstmt.setString(6, attempt.filesChanged);
                pstmt.setString(7, attempt.codeChangeSummary);
                pstmt.setString(8, attempt.commitId);
                pstmt.setString(9, attempt.buildId);
                pstmt.setString(10, attempt.deploymentId);
                pstmt.setString(11, attempt.retestRunId);
                pstmt.setString(12, attempt.result);
                pstmt.setString(13, attempt.failureReason);
                pstmt.setString(14, attempt.startedAt);
                pstmt.setString(15, attempt.completedAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertFixAttempt: " + e.getMessage());
            }
        }

        public static void insertCodeChange(CodeChange change) {
            String sql = "INSERT OR REPLACE INTO code_changes (change_id, fix_attempt_id, issue_id, file_path, change_type, before_summary, after_summary, reason, commit_id, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, change.changeId);
                pstmt.setString(2, change.fixAttemptId);
                pstmt.setString(3, change.issueId);
                pstmt.setString(4, change.filePath);
                pstmt.setString(5, change.changeType);
                pstmt.setString(6, change.beforeSummary);
                pstmt.setString(7, change.afterSummary);
                pstmt.setString(8, change.reason);
                pstmt.setString(9, change.commitId);
                pstmt.setString(10, change.createdAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertCodeChange: " + e.getMessage());
            }
        }

        public static void insertLink(IssueLink link) {
            String sql = "INSERT OR REPLACE INTO issue_links (link_id, issue_id, linked_entity_type, linked_entity_id, relationship_type, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, link.linkId);
                pstmt.setString(2, link.issueId);
                pstmt.setString(3, link.linkedEntityType);
                pstmt.setString(4, link.linkedEntityId);
                pstmt.setString(5, link.relationshipType);
                pstmt.setString(6, link.createdAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertLink: " + e.getMessage());
            }
        }

        public static void insertActivityLog(ActivityLog log) {
            String sql = "INSERT OR REPLACE INTO activity_log (activity_id, run_id, issue_id, fix_attempt_id, deployment_id, activity_type, description, metadata_json, created_by, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, log.activityId);
                pstmt.setString(2, log.runId);
                pstmt.setString(3, log.issueId);
                pstmt.setString(4, log.fixAttemptId);
                pstmt.setString(5, log.deploymentId);
                pstmt.setString(6, log.activityType);
                pstmt.setString(7, log.description);
                pstmt.setString(8, log.metadataJson);
                pstmt.setString(9, log.createdBy);
                pstmt.setString(10, log.createdAt);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                System.err.println("[DB] Error in insertActivityLog: " + e.getMessage());
            }
        }

        public static int getOccurrenceCount(String issueId) {
            String sql = "SELECT COUNT(*) FROM issue_occurrences WHERE issue_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, issueId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getOccurrenceCount: " + e.getMessage());
            }
            return 0;
        }

        public static int getFixAttemptCount(String issueId) {
            String sql = "SELECT COUNT(*) FROM fix_attempts WHERE issue_id = ?";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, issueId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in getFixAttemptCount: " + e.getMessage());
            }
            return 0;
        }

        public static void resolveIssuesForScreen(String screenId, String testRunId) {
            String sql = "SELECT * FROM issues WHERE screen_id = ? AND status != 'CLOSED'";
            try (Connection conn = SQLiteConnectionManager.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, screenId);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        Issue issue = new Issue();
                        issue.issueId = rs.getString("issue_id");
                        issue.status = "CLOSED";
                        issue.latestTestRunId = testRunId;
                        issue.updatedAt = Instant.now().toString();
                        issue.closedAt = Instant.now().toString();
                        issue.resolvedAt = Instant.now().toString();
                        updateIssue(issue);
                        
                        // Status History
                        IssueStatusHistory history = new IssueStatusHistory();
                        history.historyId = java.util.UUID.randomUUID().toString();
                        history.issueId = issue.issueId;
                        history.previousStatus = rs.getString("status");
                        history.newStatus = "CLOSED";
                        history.reason = "Test passed successfully in run: " + testRunId;
                        history.changedBy = "ANTIGRAVITY";
                        history.testRunId = testRunId;
                        history.changedAt = issue.updatedAt;
                        insertStatusHistory(history);
                    }
                }
            } catch (SQLException e) {
                System.err.println("[DB] Error in resolveIssuesForScreen: " + e.getMessage());
            }
        }
    }
}

