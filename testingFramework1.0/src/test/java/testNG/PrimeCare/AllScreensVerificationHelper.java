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
    }

    /**
     * Loads active screens from governance.db with fallback to mapped Page Objects.
     */
    public Object[][] getActiveScreens() {
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

        System.out.println("  Loaded " + list.size() + " active screens for verification.");

        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    /**
     * Checks if current browser URL matches expected target route.
     */
    private boolean isCorrectPage(WebDriver driver, String expectedRoute) {
        try {
            String currentUrl = driver.getCurrentUrl();
            String cleanExpected = expectedRoute.split("\\?")[0];
            return currentUrl != null && currentUrl.contains(cleanExpected);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Executes 2-stage verification:
     * Stage 1: Page Correctness Pre-Check Validation & Recovery
     * Stage 2: Page Object & DOM Component Verification
     */
    public void executeVerification(ScreenTestData screen, WebDriver driver, Runnable clearSession, NavigationFunction navigator) {
        System.out.println("====== STARTING VERIFICATION FOR SCREEN " + screen.screenId + " (" + screen.screenName + ") ======");
        
        String cleanRoute = screen.route.split("\\?")[0];
        String className = routeToClassMap.get(cleanRoute);
        if (className == null) {
            System.out.println("  [Skip] No PageObject class found for route: " + cleanRoute);
            return;
        }

        System.out.println("  Target Route: " + screen.route);
        System.out.println("  PageObject Class: " + className);

        String base = screen.baseUrl;
        if (base == null || base.isEmpty()) {
            base = "https://primecare-clinic.pages.dev";
        }
        String targetUrl = base + screen.route + (screen.route.contains("?") ? "&" : "?") + "enable-semantics=true";

        try {
            if (clearSession != null) {
                clearSession.run();
            }
            driver.get(targetUrl);

            // =========================================================================
            // STAGE 1: PAGE CORRECTNESS PRE-CHECK
            // Verify browser is on the correct page before scanning page objects.
            // =========================================================================
            System.out.println("  [STAGE 1] Checking page correctness for route: " + screen.route);
            boolean isPageRight = isCorrectPage(driver, screen.route);
            if (!isPageRight) {
                System.out.println("  [STAGE 1] Page pre-check failed. Initiating 4-step recovery navigation...");
                boolean targetReached = navigator.navigate(screen.route, screen.testEmail, screen.testPassword);
                Assert.assertTrue(targetReached, "Page correctness pre-check failed: Could not navigate to " + screen.route);
                System.out.println("  [STAGE 1] Recovery complete! Browser is now on target page.");
            } else {
                System.out.println("  [STAGE 1] Page pre-check passed! Browser is confirmed on target page.");
            }

            // =========================================================================
            // STAGE 2: PAGE OBJECT & DOM COMPONENT SCANNING
            // Scan, instantiate Page Object class, and execute isLoaded() assertions.
            // =========================================================================
            System.out.println("  [STAGE 2] Scanning page objects and executing DOM assertions for class: " + className);
            try {
                Class<?> clazz = Class.forName("pageobjects.primecare.ui." + className);
                Constructor<?> constructor = clazz.getDeclaredConstructor();
                Object pageInstance = constructor.newInstance();
                Method isLoadedMethod = clazz.getMethod("isLoaded");
                boolean loaded = (Boolean) isLoadedMethod.invoke(pageInstance);
                Assert.assertTrue(loaded, "Failed to verify screen is loaded: " + className);
                System.out.println("====== SUCCESSFUL VERIFICATION FOR SCREEN " + screen.screenId + " ======");
            } catch (Exception e) {
                Assert.fail("Reflection execution of page object failed: " + e.getMessage(), e);
            }
        } finally {
            try {
                if (driver instanceof TakesScreenshot) {
                    File srcFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
                    File destDir = new File("screenshots");
                    if (!destDir.exists()) {
                        destDir.mkdirs();
                    }
                    File destFile = new File(destDir, className + ".png");
                    Files.copy(srcFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("  [Screenshot] Saved screenshot to: " + destFile.getAbsolutePath());
                }
            } catch (Exception ex) {
                System.err.println("  [Screenshot] Failed to capture screenshot: " + ex.getMessage());
            }
        }
    }
}
