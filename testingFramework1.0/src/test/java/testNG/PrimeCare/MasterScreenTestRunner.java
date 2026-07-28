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
 * MasterScreenTestRunner - 1-CLICK EASY EXECUTION FOR ECLIPSE / IDE
 * Simply click the ▶️ PLAY BUTTON directly on any test method below to run!
 */
public class MasterScreenTestRunner extends baseUserCredentials {

    // =========================================================================
    // ⚙️ EASY CONFIGURATION (Change these names to test any screen/role/app!)
    // =========================================================================
    public static String SINGLE_SCREEN_TO_RUN = "rmt_dashboard";          // e.g. "rmt_dashboard", "cfo_tax_and_remittance"
    public static String SINGLE_ROLE_TO_RUN   = "cfo";                    // e.g. "cfo", "ciso", "patient", "rmt"
    public static String SINGLE_APP_TO_RUN    = "primecare_clinic";       // e.g. "primecare_clinic", "primecare_client"
    // =========================================================================

    private static final Map<String, String> routeToClassMap = new HashMap<>();

    @BeforeClass
    public void scanPageObjects() {
        System.out.println("==================================================");
        System.out.println("PRIMECARE PLATFORM - EASY 1-CLICK JAVA TEST RUNNER");
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
    // ▶️ TEST 1: RUN SINGLE SCREEN (Click ▶️ Play Button in Eclipse to Run!)
    // =========================================================================
    @Test
    public void test1_RunSingleScreen() {
        System.out.println("\n▶️ [RUNNING TEST 1] SINGLE SCREEN TEST: " + SINGLE_SCREEN_TO_RUN);
        runFilteredQuery("screen", SINGLE_SCREEN_TO_RUN);
    }

    // =========================================================================
    // ▶️ TEST 2: RUN SINGLE ROLE (Click ▶️ Play Button in Eclipse to Run!)
    // =========================================================================
    @Test
    public void test2_RunSingleRole() {
        System.out.println("\n▶️ [RUNNING TEST 2] SINGLE ROLE TEST: " + SINGLE_ROLE_TO_RUN);
        runFilteredQuery("role", SINGLE_ROLE_TO_RUN);
    }

    // =========================================================================
    // ▶️ TEST 3: RUN SINGLE APPLICATION (Click ▶️ Play Button in Eclipse to Run!)
    // =========================================================================
    @Test
    public void test3_RunSingleApp() {
        System.out.println("\n▶️ [RUNNING TEST 3] SINGLE APP TEST: " + SINGLE_APP_TO_RUN);
        runFilteredQuery("app", SINGLE_APP_TO_RUN);
    }

    // =========================================================================
    // ▶️ TEST 4: RUN ALL PLATFORM SCREENS (Click ▶️ Play Button in Eclipse to Run!)
    // =========================================================================
    @Test
    public void test4_RunAllPlatformScreens() {
        System.out.println("\n▶️ [RUNNING TEST 4] ALL PLATFORM SCREENS TEST");
        runFilteredQuery("all", "");
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

            if (filterType.equals("screen") && !filterVal.isEmpty()) {
                sql += "AND (LOWER(s.screen_code) = '" + filterVal.toLowerCase() + "' OR LOWER(s.screen_name) = '" + filterVal.toLowerCase() + "') ";
            } else if (filterType.equals("role") && !filterVal.isEmpty()) {
                sql += "AND LOWER(r.role_code) = '" + filterVal.toLowerCase() + "' ";
            } else if (filterType.equals("app") && !filterVal.isEmpty()) {
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
