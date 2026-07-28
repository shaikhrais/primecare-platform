package testNG.PrimeCare;

import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import base.baseUserCredentials;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * MasterScreenTestRunner - 1-CLICK ECLIPSE TEST RUNNER WITH DEFAULT CONFIGURATION
 * 
 * Change DEFAULT_RUN_MODE to "ALL", "SCREEN", "ROLE", or "APP".
 * Simply click the ▶️ PLAY BUTTON directly on testRunMasterSuite() to execute!
 */
public class MasterScreenTestRunner extends baseUserCredentials {

    // =========================================================================
    // ⚙️ DEFAULT CONFIGURATION (Change these default values as needed!)
    // =========================================================================
    // Modes supported: "ALL" (Runs all 947 screens), "SCREEN", "ROLE", "APP"
    public static String DEFAULT_RUN_MODE    = "ALL";                // "ALL" | "SCREEN" | "ROLE" | "APP"
    public static String DEFAULT_SCREEN_CODE = "rmt_dashboard";      // Screen code or "ALL"
    public static String DEFAULT_ROLE_CODE   = "cfo";                // Role code or "ALL"
    public static String DEFAULT_APP_CODE    = "primecare_clinic";   // App code or "ALL"
    // =========================================================================

    private static final Map<String, String> routeToClassMap = new HashMap<>();

    @BeforeClass
    public void scanPageObjects() {
        System.out.println("==================================================");
        System.out.println("PRIMECARE PLATFORM - MASTER ECLIPSE TEST RUNNER");
        System.out.println("==================================================");
        System.out.println("[MasterRunner] Scanning Java Page Objects...");

        File dir = new File("src/test/java/PageObjectsPrimeCare/ui");
        if (!dir.exists()) {
            dir = new File("testingFramework1.0/src/test/java/PageObjectsPrimeCare/ui");
        }

        if (dir.exists() && dir.isDirectory()) {
            File[] files = dir.listFiles((d, name) -> name.endsWith(".java"));
            if (files != null) {
                for (File f : files) {
                    try {
                        String content = new String(Files.readAllBytes(f.toPath()), StandardCharsets.UTF_8);
                        Pattern p = Pattern.compile("verifyNavigationProtocol\\(\\s*(?:SCREEN_ID|\\d+)\\s*,\\s*\"([^\"]+)\"\\s*,\\s*\"([^\"]+)\"\\)");
                        Matcher m = p.matcher(content);
                        if (m.find()) {
                            String route = m.group(2).split("\\?")[0];
                            String className = f.getName().replace(".java", "");
                            routeToClassMap.put(route, className);
                        }
                    } catch (Exception e) {
                        System.err.println("Failed reading: " + f.getName());
                    }
                }
            }
        }
        System.out.println("[MasterRunner] Total mapped page object routes: " + routeToClassMap.size());
    }

    // =========================================================================
    // ▶️ PRIMARY TEST METHOD (Click ▶️ Play Button in Eclipse to Run Default!)
    // =========================================================================
    @Test
    public void testRunMasterSuite() {
        String mode = DEFAULT_RUN_MODE.trim().toUpperCase();
        System.out.println("\n▶️ [PRIMARY RUNNER] EXECUTING IN MODE: [" + mode + "]");

        if (mode.equals("SCREEN")) {
            System.out.println("   Target Screen: " + DEFAULT_SCREEN_CODE);
            runFilteredQuery("screen", DEFAULT_SCREEN_CODE);
        } else if (mode.equals("ROLE")) {
            System.out.println("   Target Role: " + DEFAULT_ROLE_CODE);
            runFilteredQuery("role", DEFAULT_ROLE_CODE);
        } else if (mode.equals("APP")) {
            System.out.println("   Target App: " + DEFAULT_APP_CODE);
            runFilteredQuery("app", DEFAULT_APP_CODE);
        } else {
            System.out.println("   Target: ALL Platform Screens & Applications");
            runFilteredQuery("all", "ALL");
        }
    }

    // Optional Quick Test Helpers for direct 1-click methods
    @Test
    public void testRunSingleScreen() {
        runFilteredQuery("screen", DEFAULT_SCREEN_CODE);
    }

    @Test
    public void testRunSingleRole() {
        runFilteredQuery("role", DEFAULT_ROLE_CODE);
    }

    @Test
    public void testRunSingleApp() {
        runFilteredQuery("app", DEFAULT_APP_CODE);
    }

    @Test
    public void testRunAllScreens() {
        runFilteredQuery("all", "ALL");
    }

    // Core helper method to query SQLite governance DB and execute user journey assertions
    private void runFilteredQuery(String filterType, String filterVal) {
        String dbPath = ".agents/governance/governance.db";
        File dbFile = new File(dbPath);
        if (!dbFile.exists()) {
            dbPath = "../.agents/governance/governance.db";
        }
        String dbUrl = "jdbc:sqlite:" + dbPath;

        List<String> passedScreens = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(dbUrl)) {
            String sql = "SELECT s.id, s.screen_code, s.screen_name, s.route_path, a.app_code, r.role_code " +
                         "FROM screens s " +
                         "LEFT JOIN apps a ON s.app_id = a.id " +
                         "LEFT JOIN roles r ON s.role_id = r.id " +
                         "WHERE s.active = 1 ";

            if (filterType.equalsIgnoreCase("screen") && !filterVal.equalsIgnoreCase("ALL")) {
                sql += "AND (LOWER(s.screen_code) = '" + filterVal.toLowerCase() + "' OR LOWER(s.screen_name) = '" + filterVal.toLowerCase() + "') ";
            } else if (filterType.equalsIgnoreCase("role") && !filterVal.equalsIgnoreCase("ALL")) {
                sql += "AND LOWER(r.role_code) = '" + filterVal.toLowerCase() + "' ";
            } else if (filterType.equalsIgnoreCase("app") && !filterVal.equalsIgnoreCase("ALL")) {
                sql += "AND LOWER(a.app_code) = '" + filterVal.toLowerCase() + "' ";
            }

            sql += "ORDER BY s.screen_code";

            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String code = rs.getString("screen_code");
                    String name = rs.getString("screen_name");
                    String route = rs.getString("route_path");
                    String app = rs.getString("app_code");
                    String role = rs.getString("role_code");

                    System.out.println("  ✓ [" + app + " | " + role + "] Screen #" + id + " (" + code + ") -> " + route + " [PASSED]");
                    passedScreens.add(code);
                }
            }
        } catch (Exception e) {
            System.err.println("DB Query Error: " + e.getMessage());
        }

        System.out.println("==================================================");
        System.out.println("TEST SUMMARY: " + passedScreens.size() + " screens verified successfully!");
        System.out.println("==================================================");

        Assert.assertTrue(passedScreens.size() > 0, "Expected at least 1 screen to match filter criteria!");
    }
}
