package primecare.testing.framework;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DatabaseHealthCheck {

    public static void verifyDatabaseState() {
        System.out.println("[HEALTH] Running database integrity checks...");
        List<String> requiredTables = Arrays.asList(
            "schema_migrations", "applications", "screens", "testing_layers",
            "screen_layer_requirements", "ui_components", "screen_functions",
            "business_rules", "api_endpoints", "api_test_cases", "integration_mappings",
            "database_validation_rules", "roles", "permissions", "role_permissions",
            "workflows", "workflow_steps", "test_executions", "test_results",
            "test_evidence", "defects", "verification_summary", "certification_records",
            "test_execution_plans", "test_execution_plan_items", "screen_test_cases"
        );

        List<String> missingTables = new ArrayList<>();

        try (Connection conn = SQLiteConnectionManager.getConnection()) {
            DatabaseMetaData dbMeta = conn.getMetaData();
            for (String table : requiredTables) {
                try (ResultSet rs = dbMeta.getTables(null, null, table, null)) {
                    if (!rs.next()) {
                        missingTables.add(table);
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Database health check command failed: " + e.getMessage(), e);
        }

        if (!missingTables.isEmpty()) {
            throw new IllegalStateException("DatabaseIntegrityException: Missing required tables: " + missingTables);
        }

        System.out.println("[HEALTH] All required tables are verified and active.");
    }
}

