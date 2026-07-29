package testNG.PrimeCare;

import primecare.testing.base.BaseUiTest;
import primecare.testing.framework.Models.ScreenDefinition;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.Repositories.ScreenRepository;
import primecare.testing.framework.PlaceholderDetectionService;
import primecare.testing.validation.TestLayer;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;
import java.util.List;

@TestLayer(TestingLayerCode.L1)
public class L1RouteTest extends BaseUiTest {

    @DataProvider(name = "screens")
    public Object[][] getScreens() {
        List<ScreenDefinition> list = ScreenRepository.getScreens();
        list.removeIf(s -> !"language".equals(s.screenKey) && !"login".equals(s.screenKey) && !"success".equals(s.screenKey));
        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    @Test(dataProvider = "screens", groups = {"l1", "smoke"})
    public void verifyRouteAndNavigation(ScreenDefinition screen) {
        System.out.println("[L1] Testing route navigation for screen: " + screen.screenKey + " at " + screen.route);
        
        String base = System.getProperty("APP_BASE_URL");
        if (base == null || base.isEmpty()) {
            base = appProps.getProperty("APP_BASE_URL");
        }
        if (base == null || base.isEmpty()) {
            try {
                primecare.testing.framework.planning.Models.ApplicationDefinition app = 
                    primecare.testing.framework.database.Repositories.ApplicationRepository.getApplicationById(screen.applicationId);
                if (app != null && app.baseUrl != null && !app.baseUrl.isEmpty()) {
                    base = app.baseUrl;
                }
            } catch (Exception e) {}
        }
        if (base == null || base.isEmpty()) {
            base = "https://primecare-clinic.pages.dev";
        }
        String targetUrl = base + screen.route;

        String email = System.getProperty("username.admin", "clinic@primecare.com");
        String password = System.getProperty("password.admin", "Password123");

        if (screen.requiredRole != null && !screen.requiredRole.isEmpty() && !"ANY".equalsIgnoreCase(screen.requiredRole)) {
            try {
                primecare.testing.framework.planning.Models.RoleDefinition rd = 
                    primecare.testing.framework.database.Repositories.RoleRepository.getRoleByKey(screen.requiredRole.trim().toUpperCase());
                if (rd != null && rd.testEmail != null && !rd.testEmail.isEmpty()) {
                    email = rd.testEmail;
                    password = (rd.testPassword != null && !rd.testPassword.isEmpty()) ? rd.testPassword : "Test@12345";
                }
            } catch (Exception e) {}
        }

        // Determine if public or protected page
        boolean isPublic = "/login".equals(screen.route) 
                || "/language".equals(screen.route) 
                || "/invalid-test-path-for-404".equals(screen.route) 
                || screen.route.contains("login") 
                || screen.route.contains("language");

        // Wait for page to load and perform login if protected
        By marker;
        if (isPublic) {
            if (screen.route.contains("language")) {
                marker = By.xpath("//*[contains(@aria-label, 'lang-english') or contains(text(), 'lang-english')]");
            } else {
                marker = By.xpath("//*[contains(@aria-label, 'login-email') or contains(text(), 'login-email')]");
            }
        } else {
            // For layout/protected pages, wait for logout button or sidebar
            marker = By.xpath("//*[contains(@aria-label, 'topbar-logout-button') or contains(text(), 'topbar-logout-button') or contains(@aria-label, 'app-sidebar') or contains(text(), 'app-sidebar')]");
        }

        try {
            pageRecovery.navigateToTargetScreen(targetUrl, screen.screenKey, email, password);
        } catch (Throwable e) {
            captureScreenshot(screen.screenKey + "_failed");
            Assert.fail("[L1] Navigation to target screen failed: " + targetUrl + ". Error: " + e.getMessage());
        }

        // 1. Identify if we are on the right screen URL
        String currentUrl = driver.getCurrentUrl();
        System.out.println("[L1] Current URL: " + currentUrl + " | Expected route: " + screen.route);

        // 2. Detect placeholders
        boolean isPlaceholder = PlaceholderDetectionService.isPlaceholderPage(driver);
        Assert.assertFalse(isPlaceholder, "Page: " + screen.screenKey + " contains placeholder construction texts!");

        // 3. See if screen is in layout with sidebar, top bar, and content (for protected routes)
        if (!isPublic) {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
            try {
                wait.until(d -> pageRecovery.isElementVisible("app-sidebar"));
            } catch (Exception e) {
                captureScreenshot(screen.screenKey + "_sidebar_failed");
                Assert.fail("Layout Check Failed: Sidebar 'app-sidebar' not found or not rendered for screen: " + screen.screenKey);
            }
            try {
                wait.until(d -> pageRecovery.isElementVisible("app-topbar"));
            } catch (Exception e) {
                Assert.fail("Layout Check Failed: Topbar 'app-topbar' not found or not rendered for screen: " + screen.screenKey);
            }
            try {
                wait.until(d -> pageRecovery.isElementVisible("app-content-slot"));
            } catch (Exception e) {
                Assert.fail("Layout Check Failed: Content area 'app-content-slot' not found or not rendered for screen: " + screen.screenKey);
            }
            
            System.out.println("[L1] Layout Check Successful: Sidebar, Topbar, and Content Area are all correctly present on the screen.");
        }

        System.out.println("[L1] Navigation verification successful for screen: " + screen.screenKey);
    }
}

