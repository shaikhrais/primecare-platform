package testNG.PrimeCare;

import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import base.baseUserCredentials;
import utilities.PageRecoveryUtility;
import utilities.PageRecoveryUtility.PageState;

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
            dir = new File("testingFramework1.0/src/test/java/PageObjectsPrimeCare/ui");
        }
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
        String dbPath = ".agents/governance/governance.db";
        File dbFile = new File(dbPath);
        if (!dbFile.exists()) {
            dbPath = "../.agents/governance/governance.db";
        }
        if (!dbFile.exists()) {
            dbPath = "governance.db";
        }

        String dbUrl = "jdbc:sqlite:" + dbPath;
        try (Connection conn = DriverManager.getConnection(dbUrl)) {
            Map<Integer, String> appUrls = new HashMap<>();
            String appsSql = "SELECT id, base_url FROM apps";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(appsSql)) {
                while (rs.next()) {
                    appUrls.put(rs.getInt("id"), rs.getString("base_url"));
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

        System.out.println("  Loaded " + list.size() + " active screens for verification.");

        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    protected void submitLoginCredentials(String email, String password) throws InterruptedException {
        Thread.sleep(1000);
        PageObjectsPrimeCare.ui.Auth2LoginScreen loginPage = new PageObjectsPrimeCare.ui.Auth2LoginScreen(driver);
        System.out.println("Attempting login via Auth2LoginScreen...");
        loginPage.Login(email, password);
    }

    @Test(dataProvider = "activeScreens")
    public void verifyScreenLayoutAndDOM(ScreenTestData screen) {
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
            clearSessionAndCookies();
            driver.get(targetUrl);

            // =========================================================================
            // 🔍 STEP 1 & STEP 2: IDENTIFY PAGE STATE & EXECUTE CORRESPONDING FLOW
            // =========================================================================
            PageRecoveryUtility recovery = new PageRecoveryUtility(driver, base + "/login");
            PageState state = recovery.identifyPageState();

            if (state == PageState.LANGUAGE_PAGE) {
                System.out.println("  -> [State Identified: LANGUAGE_PAGE] Running Language Flow...");
                recovery.handleLanguageFlow();
                Thread.sleep(1000);
                // Check state again after language selection
                state = recovery.identifyPageState();
            }

            if (state == PageState.LOGIN_PAGE) {
                System.out.println("  -> [State Identified: LOGIN_PAGE] Running Login Flow...");
                recovery.handleLoginFlow(screen.testEmail, screen.testPassword);
                Thread.sleep(1000);
            } else if (state == PageState.SYSTEM_ERROR) {
                System.out.println("  -> [State Identified: SYSTEM_ERROR] Recording Error & Attempting Recovery...");
                recovery.recordSystemError();
                recovery.recoverToLoginPage();
            }

            // Check actual URL after flow execution
            String actualUrl = driver.getCurrentUrl();
            System.out.println("  -> Actual URL after flow execution: " + actualUrl);

            // Dynamically instantiate POM class and invoke isLoaded()
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
