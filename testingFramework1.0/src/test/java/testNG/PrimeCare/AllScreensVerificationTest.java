package testNG.PrimeCare;

import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import base.baseUserCredentials;

import java.io.File;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
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

public class AllScreensVerificationTest extends baseUserCredentials {

    private static final Map<String, String> routeToClassMap = new HashMap<>();

    @BeforeClass
    public void scanPageObjects() {
        System.out.println("====== SCANNING PAGE OBJECTS ======");
        File dir = new File("src/test/java/PageObjectsPrimeCare/ui");
        if (!dir.exists()) {
            dir = new File("H:/My Drive/eclipse-workspace/testingFramework1.0/src/test/java/PageObjectsPrimeCare/ui");
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

    @DataProvider(name = "activeScreens")
    public Object[][] getActiveScreens() {
        List<ScreenTestData> list = new ArrayList<>();
        String dbUrl = "jdbc:sqlite:governance.db";
        try (Connection conn = DriverManager.getConnection(dbUrl)) {
            // Build application-to-baseUrl map
            Map<Integer, String> appUrls = new HashMap<>();
            String appsSql = "SELECT application_id, base_url FROM applications";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(appsSql)) {
                while (rs.next()) {
                    appUrls.put(rs.getInt("application_id"), rs.getString("base_url"));
                }
            }

            // Build role-to-credentials map
            Map<String, String[]> roleCreds = new HashMap<>();
            String rolesSql = "SELECT role_key, test_email, test_password FROM roles WHERE active = 1";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(rolesSql)) {
                while (rs.next()) {
                    String roleKey = rs.getString("role_key").toUpperCase();
                    String email = rs.getString("test_email");
                    String pass = rs.getString("test_password");
                    roleCreds.put(roleKey, new String[]{email, pass});
                }
            }

            // Query active screens
            String screensSql = "SELECT screen_id, screen_name, route, required_role, application_id FROM screens WHERE active = 1";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(screensSql)) {
                while (rs.next()) {
                    int sid = rs.getInt("screen_id");
                    String sname = rs.getString("screen_name");
                    String route = rs.getString("route");
                    String reqRole = rs.getString("required_role");
                    int appId = rs.getInt("application_id");

                    // Bypasses (language, login, success are handled during recovery)
                    if ("/language".equals(route) || "/login".equals(route) || "/success".equals(route) || "/invalid-test-path-for-404".equals(route)) {
                        continue;
                    }

                    String email = "qa.psw@test.primecare.local"; // Fallback role email
                    String password = "Test@12345";
                    if (reqRole != null && !reqRole.isEmpty() && !"ANY".equalsIgnoreCase(reqRole)) {
                        String[] creds = roleCreds.get(reqRole.trim().toUpperCase());
                        if (creds != null && creds[0] != null && !creds[0].isEmpty()) {
                            email = creds[0];
                            password = creds[1] != null ? creds[1] : "Test@12345";
                        }
                    }

                    String baseUrl = appUrls.get(appId);
                    list.add(new ScreenTestData(sid, sname, route, reqRole, email, password, baseUrl));
                }
            }
        } catch (Exception e) {
            System.err.println("Failed to read screens from SQLite: " + e.getMessage());
        }

        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    protected void submitLoginCredentials(String email, String password) throws InterruptedException {
        Thread.sleep(2000);
        PageObjectsPrimeCare.ui.Auth2LoginScreen loginPage = new PageObjectsPrimeCare.ui.Auth2LoginScreen(driver);
        System.out.println("Attempting login...");
        loginPage.Login(email, password);
    }

    @Test(dataProvider = "activeScreens")
    public void verifyScreenLayoutAndDOM(ScreenTestData screen) {
        System.out.println("====== STARTING VERIFICATION FOR SCREEN " + screen.screenId + " ======");
        
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
            clearSessionAndCookies();
            // Invoke redirection recovery to login/redirect to target page
            try {
                redirectToRequestedPage(
                    targetUrl,
                    className,
                    screen.testEmail,
                    screen.testPassword,
                    this::submitLoginCredentials
                );
            } catch (Exception e) {
                Assert.fail("Redirection recovery failed: " + e.getMessage());
            }

            // Dynamically instantiate class and call isLoaded()
            try {
                Class<?> clazz = Class.forName("PageObjectsPrimeCare.ui." + className);
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
            // Capture screenshot named exactly as the POM class name
            try {
                if (driver instanceof org.openqa.selenium.TakesScreenshot) {
                    java.io.File srcFile = ((org.openqa.selenium.TakesScreenshot) driver).getScreenshotAs(org.openqa.selenium.OutputType.FILE);
                    java.io.File destDir = new java.io.File("c:/Users/Admin2/Documents/GitHub/primecare-platform/screenshots");
                    if (!destDir.exists()) {
                        destDir.mkdirs();
                    }
                    java.io.File destFile = new java.io.File(destDir, className + ".png");
                    java.nio.file.Files.copy(srcFile.toPath(), destFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    System.out.println("  [Screenshot] Saved screenshot to: " + destFile.getAbsolutePath());
                }
            } catch (Exception ex) {
                System.err.println("  [Screenshot] Failed to capture screenshot: " + ex.getMessage());
            }
        }
    }
}
