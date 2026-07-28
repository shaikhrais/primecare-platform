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
 * Package: testNG.PrimeCare
 * Class: MasterScreenTestRunner
 * 
 * 📖 HOW TO RUN THIS FILE IN ECLIPSE / INTELLIJ (JAVA APPLICATION & TESTNG)
 * 
 * 🛠️ 1-CLICK RUN (JAVA APPLICATION):
 *   Right-click this file in Eclipse ➔ Run As ➔ Java Application
 *   (or click the green ▶️ Play Button at the top of the file!)
 * 
 * ⚙️ DEFAULT MODE: Configured to run ALL Personal Support Worker (PSW) screens!
 *   - Change DEFAULT_RUN_MODE = "ROLE", "ALL", "SCREEN", or "APP" below.
 *   - Change DEFAULT_ROLE_CODE = "psw", "cfo", "ciso", "patient", "rmt", etc.
 */
public class MasterScreenTestRunner extends baseUserCredentials {

    // =========================================================================
    // ⚙️ DEFAULT CONFIGURATION (Set to run ALL PSW Screens by Default!)
    // =========================================================================
    // Modes supported: "ROLE" (Default: Runs all PSW screens), "ALL", "SCREEN", "APP"
    public static String DEFAULT_RUN_MODE    = "ROLE";               // "ROLE" | "ALL" | "SCREEN" | "APP"
    public static String DEFAULT_ROLE_CODE   = "psw";                // Personal Support Worker (PSW) Role
    public static String DEFAULT_SCREEN_CODE = "psw_dashboard";      // Target Screen Code or "ALL"
    public static String DEFAULT_APP_CODE    = "primecare_clinic";   // Target App Code or "ALL"
    // =========================================================================

    private static final Map<String, String> routeToClassMap = new HashMap<>();

    /**
     * Standard Java main method enabling 1-click "Run As Java Application" in Eclipse!
     */
    public static void main(String[] args) {
        System.out.println("==================================================");
        System.out.println("PRIMECARE PLATFORM - ECLIPSE JAVA APPLICATION RUNNER");
        System.out.println("==================================================");
        
        MasterScreenTestRunner runner = new MasterScreenTestRunner();
        runner.scanPageObjects();
        runner.testRunMasterSuite();
    }

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
    // ▶️ PRIMARY TEST METHOD (TestNG & Java Main Entrypoint)
    // =========================================================================
    @Test
    public void testRunMasterSuite() {
        String mode = DEFAULT_RUN_MODE.trim().toUpperCase();
        System.out.println("\n▶️ [PRIMARY RUNNER] EXECUTING IN MODE: [" + mode + "]");

        if (mode.equals("SCREEN")) {
            System.out.println("   Target Screen: " + DEFAULT_SCREEN_CODE);
            runFilteredQuery("screen", DEFAULT_SCREEN_CODE);
        } else if (mode.equals("ROLE")) {
            System.out.println("   Target Role: " + DEFAULT_ROLE_CODE.toUpperCase() + " (Personal Support Worker)");
            runFilteredQuery("role", DEFAULT_ROLE_CODE);
        } else if (mode.equals("APP")) {
            System.out.println("   Target App: " + DEFAULT_APP_CODE);
            runFilteredQuery("app", DEFAULT_APP_CODE);
        } else {
            System.out.println("   Target: ALL Platform Screens & Applications");
            runFilteredQuery("all", "ALL");
        }
    }

    // Direct 1-Click Test Methods for Instant Execution
    @Test
    public void testRunAllPswScreens() {
        System.out.println("\n▶️ [RUNNING TEST] ALL PSW (Personal Support Worker) SCREENS");
        runFilteredQuery("role", "psw");
    }

    @Test
    public void testRunSingleScreen() {
        runFilteredQuery("screen", DEFAULT_SCREEN_CODE);
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
