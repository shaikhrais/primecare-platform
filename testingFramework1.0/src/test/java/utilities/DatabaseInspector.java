package utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseInspector {

    private static final String DB_URL = "jdbc:sqlite:governance.db";

    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("        PrimeCare Governance Database Inspector   ");
        System.out.println("==================================================");

        try (Connection conn = DriverManager.getConnection(DB_URL)) {
            if (conn != null) {
                System.out.println("Successfully connected to the database at: governance.db\n");
                
                printApplicationSummary(conn);
                printRoleSummary(conn);
                printScreenSummary(conn);
                printComponentSummary(conn);
            }
        } catch (SQLException e) {
            System.err.println("Database connection or query failed: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("==================================================");
    }

    private static void printApplicationSummary(Connection conn) throws SQLException {
        System.out.println("--- APPLICATIONS ---");
        String countQuery = "SELECT COUNT(*) FROM applications";
        String selectQuery = "SELECT application_id, application_key, application_name FROM applications";
        
        try (Statement stmt = conn.createStatement()) {
            // Print count
            try (ResultSet rs = stmt.executeQuery(countQuery)) {
                if (rs.next()) {
                    System.out.println("Total Applications: " + rs.getInt(1));
                }
            }
            // List entries
            try (ResultSet rs = stmt.executeQuery(selectQuery)) {
                System.out.printf("  %-5s | %-20s | %-30s%n", "ID", "Key", "Name");
                System.out.println("  -------------------------------------------------------------");
                while (rs.next()) {
                    System.out.printf("  %-5d | %-20s | %-30s%n", 
                        rs.getInt("application_id"), 
                        rs.getString("application_key"), 
                        rs.getString("application_name")
                    );
                }
            }
        }
        System.out.println();
    }

    private static void printRoleSummary(Connection conn) throws SQLException {
        System.out.println("--- ROLES ---");
        String countQuery = "SELECT COUNT(*) FROM roles";
        String selectQuery = "SELECT role_id, role_key, role_name, test_email FROM roles";
        
        try (Statement stmt = conn.createStatement()) {
            // Print count
            try (ResultSet rs = stmt.executeQuery(countQuery)) {
                if (rs.next()) {
                    System.out.println("Total Roles: " + rs.getInt(1));
                }
            }
            // List entries
            try (ResultSet rs = stmt.executeQuery(selectQuery)) {
                System.out.printf("  %-5s | %-30s | %-30s | %-30s%n", "ID", "Key", "Name", "Test Email");
                System.out.println("  --------------------------------------------------------------------------------------------------");
                while (rs.next()) {
                    System.out.printf("  %-5d | %-30s | %-30s | %-30s%n", 
                        rs.getInt("role_id"), 
                        rs.getString("role_key"), 
                        rs.getString("role_name"),
                        rs.getString("test_email")
                    );
                }
            }
        }
        System.out.println();
    }

    private static void printScreenSummary(Connection conn) throws SQLException {
        System.out.println("--- SCREENS (First 20) ---");
        String countQuery = "SELECT COUNT(*) FROM screens";
        String selectQuery = "SELECT screen_id, application_id, screen_key, screen_name FROM screens LIMIT 20";
        
        try (Statement stmt = conn.createStatement()) {
            // Print count
            try (ResultSet rs = stmt.executeQuery(countQuery)) {
                if (rs.next()) {
                    System.out.println("Total Screens in DB: " + rs.getInt(1));
                }
            }
            // List entries
            try (ResultSet rs = stmt.executeQuery(selectQuery)) {
                System.out.printf("  %-5s | %-6s | %-40s | %-45s%n", "ID", "App ID", "Key", "Name");
                System.out.println("  ----------------------------------------------------------------------------------------------------");
                while (rs.next()) {
                    System.out.printf("  %-5d | %-6d | %-40s | %-45s%n", 
                        rs.getInt("screen_id"), 
                        rs.getInt("application_id"), 
                        rs.getString("screen_key"), 
                        rs.getString("screen_name")
                    );
                }
            }
        }
        System.out.println();
    }

    private static void printComponentSummary(Connection conn) throws SQLException {
        System.out.println("--- UI COMPONENTS ---");
        String countQuery = "SELECT COUNT(*) FROM ui_components";
        String typeBreakdownQuery = "SELECT component_type, COUNT(*) as c FROM ui_components GROUP BY component_type";
        String sampleQuery = "SELECT component_id, screen_id, component_key, component_type FROM ui_components LIMIT 10";
        
        try (Statement stmt = conn.createStatement()) {
            // Print count
            try (ResultSet rs = stmt.executeQuery(countQuery)) {
                if (rs.next()) {
                    System.out.println("Total UI Components: " + rs.getInt(1));
                }
            }
            // Breakdown by type
            System.out.println("  Breakdown by Component Type:");
            try (ResultSet rs = stmt.executeQuery(typeBreakdownQuery)) {
                while (rs.next()) {
                    System.out.printf("    - %-20s: %d%n", rs.getString("component_type"), rs.getInt("c"));
                }
            }
            // List sample
            System.out.println("\n  Sample Components (First 10):");
            try (ResultSet rs = stmt.executeQuery(sampleQuery)) {
                System.out.printf("    %-5s | %-9s | %-50s | %-20s%n", "ID", "Screen ID", "Key", "Type");
                System.out.println("    -------------------------------------------------------------------------------------------------");
                while (rs.next()) {
                    System.out.printf("    %-5d | %-9d | %-50s | %-20s%n", 
                        rs.getInt("component_id"), 
                        rs.getInt("screen_id"), 
                        rs.getString("component_key"), 
                        rs.getString("component_type")
                    );
                }
            }
        }
        System.out.println();
    }
}
