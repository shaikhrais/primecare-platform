package primecare.testing.screens.language;

import primecare.testing.base.BaseUiTest;
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.framework.database.Repositories.ApplicationRepository;
import primecare.testing.framework.planning.Models.ScreenDefinition;
import primecare.testing.framework.planning.Models.ApplicationDefinition;
import primecare.testing.framework.data.TestDataLayer;
import primecare.testing.pages.DynamicScreen;
import org.testng.Assert;
import org.testng.annotations.Test;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;

public class LanguageNavigationTest extends BaseUiTest {

    @Test(groups = {"language", "navigation", "ui"})
    public void testClickEnglishButtonGoesToLoginPage() {
        // 1. Resolve screen definition dynamically from SQLite screens table
        ScreenDefinition languageScreen = ScreenRepository.getScreenByKey("language");
        Assert.assertNotNull(languageScreen, "Language screen definition not found in database!");
        
        // 2. Fetch the corresponding application details from SQLite applications table
        ApplicationDefinition appDef = ApplicationRepository.getApplicationById(languageScreen.applicationId);
        Assert.assertNotNull(appDef, "Application definition not found for ID: " + languageScreen.applicationId);

        // 3. Resolve target URL (uses command-line/properties override, falls back to DB baseUrl)
        String route = TestDataLayer.getParameter("language", "target_route", languageScreen.route);
        String baseUrl = appProps.getProperty("APP_BASE_URL", appDef.baseUrl);
        String targetUrl = baseUrl + route;
        
        System.out.println("[TEST] Navigating to: " + targetUrl);
        try {
            driver.get(targetUrl);
            try {
                System.out.println("[TEST] Waiting 3 seconds for Flutter initialization...");
                Thread.sleep(3000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }



            pageRecovery.enableSemantics();
        } finally {
            try {
                org.openqa.selenium.logging.LogEntries logEntries = driver.manage().logs().get(org.openqa.selenium.logging.LogType.BROWSER);
                for (org.openqa.selenium.logging.LogEntry entry : logEntries) {
                    System.out.println("[BROWSER LOG] " + entry.getLevel() + " " + entry.getMessage());
                }
            } catch (Exception e) {
                System.err.println("Could not retrieve browser logs: " + e.getMessage());
            }
            dumpDom("language");
        }

        // 4. Click English selection button (locator resolved via DynamicScreen from SQLite ui_components)
        DynamicScreen languagePage = new DynamicScreen(driver, "language");
        System.out.println("[TEST] Clicking English selection button resolved from DB.");
        languagePage.click("lang_english_button");

        // 5. Verify redirection matches expected route dynamically resolved from TestDataLayer / screens table
        ScreenDefinition loginScreen = ScreenRepository.getScreenByKey("login");
        Assert.assertNotNull(loginScreen, "Login screen definition not found in database!");
        
        String expectedRedirect = TestDataLayer.getParameter("language", "success_redirect_route", loginScreen.route);
        
        // Wait for redirection transition to complete
        WebDriverWait transitionWait = new WebDriverWait(driver, Duration.ofSeconds(10));
        transitionWait.until(ExpectedConditions.urlContains(expectedRedirect));
        
        String currentUrl = driver.getCurrentUrl();
        System.out.println("[TEST] Redirection current URL: " + currentUrl);
        
        dumpDom("login");
        Assert.assertTrue(currentUrl.contains(expectedRedirect), 
            "Clicking the English button did not redirect to the expected login page. Current URL: " + currentUrl);
    }
}
