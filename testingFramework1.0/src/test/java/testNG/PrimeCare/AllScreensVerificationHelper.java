package testNG.PrimeCare;

import primecare.testing.framework.DatabaseConfig;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

import java.io.File;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
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
 * AllScreensVerificationHelper - Encapsulates all scanning, database data-provider loading,
 * page correctness validation, recovery navigation, page object reflection verification, and screenshot reporting.
 * Features comprehensive [CALL] and [RESULT] function tracing across all execution paths.
 */
public class AllScreensVerificationHelper {

    private final Map<String, String> routeToClassMap = new HashMap<>();

    @FunctionalInterface
    public interface NavigationFunction {
        boolean navigate(String route, String email, String password);
    }

    public static class ScreenTestData {
        public int screenId;
        public String screenName;
        public String route;
        public String requiredRole;
        public String testEmail;
        public String testPassword;
        public String baseUrl;

        public ScreenTestData(int screenId, String screenName, String route, String requiredRole, String testEmail, String testPassword, String baseUrl) {
            this.screenId = screenId;
            this.screenName = screenName;
            this.route = route;
            this.requiredRole = requiredRole;
            this.testEmail = testEmail;
            this.testPassword = testPassword;
            this.baseUrl = baseUrl;
        }

        @Override
        public String toString() {
            return "Screen " + screenId + " (" + screenName + ") -> " + route;
        }
    }

    /**
     * Scans all Page Object Java files in the pageobjects directory to build the route-to-class map.
     */
    public void scanPageObjects() {
        System.out.println("  [CALL] AllScreensVerificationHelper.scanPageObjects()");
        System.out.println("====== SCANNING PAGE OBJECTS ======");
        File dir = new File("src/test/java/pageobjects/primecare/ui");
        if (!dir.exists()) {
            dir = new File("testingFramework1.0/src/test/java/pageobjects/primecare/ui");
        }
        if (!dir.exists()) {
            dir = new File("H:/My Drive/eclipse-workspace/testingFramework1.0/src/test/java/pageobjects/primecare/ui");
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
                        System.err.println("Failed to read: " + f.getName() + " -> " + e.getMessage());
                    }
                }
            }
        }
        System.out.println("  Total mapped routes: " + routeToClassMap.size());
        System.out.println("  [RESULT] AllScreensVerificationHelper.scanPageObjects() -> Mapped " + routeToClassMap.size() + " routes.");
    }

    /**
     * Loads active screens from governance.db with fallback to mapped Page Objects.
     */
    public Object[][] getActiveScreens() {
        System.out.println("  [CALL] AllScreensVerificationHelper.getActiveScreens()");
        List<ScreenTestData> list = new ArrayList<>();
        String dbUrl = DatabaseConfig.getDbUrl();
        try (Connection conn = DriverManager.getConnection(dbUrl)) {
            Map<Integer, String> appUrls = new HashMap<>();
            String appsSql = "SELECT id, app_code FROM apps";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(appsSql)) {
                while (rs.next()) {
                    appUrls.put(rs.getInt("id"), "https://primecare-clinic.pages.dev");
                }
            }

            Map<String, String[]> roleCreds = new HashMap<>();
            String rolesSql = "SELECT role_code, test_email, test_password FROM roles WHERE active = 1";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(rolesSql)) {
                while (rs.next()) {
                    roleCreds.put(rs.getString("role_code"), new String[]{
                        rs.getString("test_email"),
                        rs.getString("test_password")
                    });
                }
            }

            String screensSql = "SELECT s.id, s.screen_name, s.route_path, s.app_id, r.role_code " +
                               "FROM screens s LEFT JOIN roles r ON s.role_id = r.id WHERE s.active = 1 ORDER BY s.id";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(screensSql)) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("screen_name");
                    String route = rs.getString("route_path");
                    String cleanRoute = route == null ? "" : route.split("\\?")[0];

                    // Filter before Selenium navigation. Previously every database row
                    // opened a browser and waited for a timeout before discovering that
                    // no Page Object existed, making skipped screens cost ~54 seconds.
                    if (!routeToClassMap.containsKey(cleanRoute)) {
                        continue;
                    }

                    int appId = rs.getInt("app_id");
                    String roleKey = rs.getString("role_code");

                    String baseUrl = appUrls.get(appId);
                    if (baseUrl == null || baseUrl.isEmpty()) {
                        baseUrl = "https://primecare-clinic.pages.dev";
                    }

                    String[] creds = roleCreds.get(roleKey);
                    String email = (creds != null) ? creds[0] : "test@primecare.ca";
                    String pass = (creds != null) ? creds[1] : "Test1234!";

                    list.add(new ScreenTestData(id, name, route, roleKey, email, pass, baseUrl));
                }
            }
        } catch (Exception e) {
            System.err.println("Database load failed: " + e.getMessage());
        }

        if (list.isEmpty()) {
            System.out.println("  [FALLBACK] Populating screen test list from mapped Page Objects...");
            int idx = 1;
            for (Map.Entry<String, String> entry : routeToClassMap.entrySet()) {
                list.add(new ScreenTestData(idx++, entry.getKey(), entry.getValue(), "ADMIN", "clinic@primecare.com", "Password123", "https://primecare-clinic.pages.dev"));
            }
        }

        System.out.println("  Loaded " + list.size() + " mapped screens for browser verification.");

        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        System.out.println("  [RESULT] AllScreensVerificationHelper.getActiveScreens() -> Returned " + data.length + " test items.");
        return data;
    }

    /**
     * Checks if current browser URL matches expected target route.
     */
    private boolean isCorrectPage(WebDriver driver, String expectedRoute) {
        System.out.println("  [CALL] AllScreensVerificationHelper.isCorrectPage(expectedRoute=\"" + expectedRoute + "\")");
        try {
            String currentUrl = driver.getCurrentUrl();
            String cleanExpected = expectedRoute.split("\\?")[0];
            boolean result = currentUrl != null && currentUrl.contains(cleanExpected);
            System.out.println("  [RESULT] AllScreensVerificationHelper.isCorrectPage() -> " + result + " (Current URL: " + currentUrl + ")");
            return result;
        } catch (Exception e) {
            System.out.println("  [RESULT] AllScreensVerificationHelper.isCorrectPage() -> false (Exception: " + e.getMessage() + ")");
            return false;
        }
    }

    /**
     * Executes verification flow:
     * 1. Scan Page Objects & Execute DOM Assertions (Navigation and Core Auth Protocol is handled by baseTest.verifyNavigationProtocol)
     */
    public void executeVerification(ScreenTestData screen, WebDriver driver, Runnable clearSession, NavigationFunction navigator) {
        System.out.println("\n  [CALL] AllScreensVerificationHelper.executeVerification(screenId=" + screen.screenId + ", screenName=\"" + screen.screenName + "\", route=\"" + screen.route + "\", role=\"" + screen.requiredRole + "\")");
        System.out.println("====== STARTING VERIFICATION FOR SCREEN " + screen.screenId + " (" + screen.screenName + ") ======");
        
        String cleanRoute = screen.route.split("\\?")[0];
        String className = routeToClassMap.get(cleanRoute);
        if (className == null) {
            System.out.println("  [Skip] No PageObject class found for route: " + cleanRoute);
            System.out.println("  [RESULT] AllScreensVerificationHelper.executeVerification() -> SKIPPED (No POM class found)");
            return;
        }

        System.out.println("  Target Route: " + screen.route);
        System.out.println("  PageObject Class: " + className);

        try {
            // Keep authenticated session active across screen verifications

            // =========================================================================
            // 🧩 NOW SCAN PAGE OBJECTS & EXECUTE DOM ASSERTIONS
            // =========================================================================
            System.out.println("  [OBJECT SCANNER] Scanning page objects and executing DOM assertions for class: " + className);
            try {
                System.out.println("  [CALL] Reflection Class.forName(\"pageobjects.primecare.ui." + className + "\")");
                Class<?> clazz = Class.forName("pageobjects.primecare.ui." + className);
                Constructor<?> constructor = clazz.getDeclaredConstructor();
                Object pageInstance = constructor.newInstance();
                Method isLoadedMethod = clazz.getMethod("isLoaded");
                
                System.out.println("  [CALL] POM Method.invoke(" + className + ".isLoaded())");
                boolean loaded = (Boolean) isLoadedMethod.invoke(pageInstance);
                System.out.println("  [RESULT] POM Method.invoke(" + className + ".isLoaded()) -> " + loaded);
                Assert.assertTrue(loaded, "Failed to verify screen is loaded: " + className);
                System.out.println("====== SUCCESSFUL VERIFICATION FOR SCREEN " + screen.screenId + " ======");
                System.out.println("  [RESULT] AllScreensVerificationHelper.executeVerification() -> PASSED.");
            } catch (Exception e) {
                System.err.println("  [RESULT] AllScreensVerificationHelper.executeVerification() -> FAILED (Reflection error: " + e.getMessage() + ")");
                Assert.fail("Reflection execution of page object failed: " + e.getMessage(), e);
            }
        } finally {
            try {
                if (driver instanceof TakesScreenshot) {
                    System.out.println("  [CALL] TakesScreenshot.getScreenshotAs(FILE)");
                    File srcFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
                    File destDir = new File("screenshots");
                    if (!destDir.exists()) {
                        destDir.mkdirs();
                    }
                    File destFile = new File(destDir, className + ".png");
                    Files.copy(srcFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("  [RESULT] Saved screenshot artifact -> " + destFile.getAbsolutePath());
                }
            } catch (Exception ex) {
                System.err.println("  [Screenshot Exception] " + ex.getMessage());
            }
        }
    }
}
