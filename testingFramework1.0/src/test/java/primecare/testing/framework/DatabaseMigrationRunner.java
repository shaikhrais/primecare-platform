package primecare.testing.framework;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class DatabaseMigrationRunner {

    public static void runMigrations() {
        System.out.println("[DB] Checking schema migrations...");
        try (Connection conn = SQLiteConnectionManager.getConnection()) {
            // Create migrations tracking table if not exists
            try (Statement stmt = conn.createStatement()) {
                stmt.execute(
                    "CREATE TABLE IF NOT EXISTS schema_migrations (" +
                    "version TEXT PRIMARY KEY," +
                    "applied_at TEXT NOT NULL" +
                    ")"
                );
            }

            // Read migrations from resources/db/migrations/
            List<String> migrations = getMigrationFiles();
            Collections.sort(migrations);

            for (String migration : migrations) {
                if (isApplied(conn, migration)) {
                    continue;
                }

                System.out.println("[DB] Applying migration: " + migration);
                String sql = loadMigrationSql(migration);
                executeSqlScript(conn, sql);
                recordApplied(conn, migration);
            }
            System.out.println("[DB] Schema migrations complete.");
        } catch (Exception e) {
            throw new RuntimeException("Migration failure: " + e.getMessage(), e);
        }
    }

    private static List<String> getMigrationFiles() {
        List<String> files = new ArrayList<>();
        // In java desktop runtime we search in directories, but in jar we use hardcoded array
        // Here we'll support both by listing the known versions
        String[] knownVersions = {"V1__init", "V2__seed", "V3__plan_tables", "V4__test_data", "V5__register_monorepo_apps", "V6__issues_protocol", "V7__deployment_snapshot_protocol", "V8__seed_login_routes"};
        for (String v : knownVersions) {
            files.add(v);
        }
        return files;
    }

    private static boolean isApplied(Connection conn, String version) throws Exception {
        String sql = "SELECT COUNT(*) FROM schema_migrations WHERE version = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, version);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    private static void recordApplied(Connection conn, String version) throws Exception {
        String sql = "INSERT INTO schema_migrations (version, applied_at) VALUES (?, datetime('now'))";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, version);
            pstmt.executeUpdate();
        }
    }

    private static String loadMigrationSql(String name) throws Exception {
        String path = "db/migrations/" + name + ".sql";
        try (InputStream in = DatabaseMigrationRunner.class.getClassLoader().getResourceAsStream(path)) {
            if (in == null) {
                throw new IllegalArgumentException("Migration script not found: " + path);
            }
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(in))) {
                return reader.lines().collect(Collectors.joining("\n"));
            }
        }
    }

    private static void executeSqlScript(Connection conn, String script) throws Exception {
        // Simple script runner that splits by ';'
        // Inside SQLite JDBC, multiple statements can also be executed directly if allowed, but splitting is safer
        String[] statements = script.split(";");
        try (Statement stmt = conn.createStatement()) {
            for (String sql : statements) {
                String trimmed = sql.trim();
                if (!trimmed.isEmpty()) {
                    stmt.execute(trimmed);
                }
            }
        }
    }
}

