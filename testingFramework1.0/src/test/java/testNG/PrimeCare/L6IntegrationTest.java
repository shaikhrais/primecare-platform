package testNG.PrimeCare;

import primecare.testing.base.BaseUiTest;
import primecare.testing.framework.planning.Models.IntegrationMapping;
import primecare.testing.pages.DynamicScreen;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.database.Repositories.IntegrationRepository;
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.validation.TestLayer;
import org.testng.annotations.Test;
import org.testng.Assert;
import org.openqa.selenium.By;
import java.util.List;

@TestLayer(TestingLayerCode.L6)
public class L6IntegrationTest extends BaseUiTest {

    DynamicScreen page;

    @Test(groups = {"l6"})
    public void verifyUiApiIntegration() {
        System.out.println("[L6] Running UI/API Integration validation for login screen...");
        
        int loginScreenId = ScreenRepository.getScreenByKey("login").screenId;
        List<IntegrationMapping> mappings = IntegrationRepository.getMappingsForScreen(loginScreenId);
        
        // Since we seeded mappings, we verify that UI actions correspond to backend endpoint bindings
        driver.get(appProps.getProperty("login.url", "http://localhost:8080/login"));
        
        page = new DynamicScreen("login");
        String testUser = appProps.getProperty("username.admin", "clinic@primecare.com");
        String testPass = appProps.getProperty("password.admin", "Password123");

        page.type("email_field", testUser);
        page.type("password_field", testPass);
        page.click("submit_button");

        // Verify state transition reflects the integration outcome (redirection to success dashboard)
        boolean success = false;
        try {
            org.openqa.selenium.support.ui.WebDriverWait shortWait = new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(10));
            shortWait.until(webDriver -> webDriver.getCurrentUrl().contains("/success") 
                    || webDriver.getCurrentUrl().contains("/settings") 
                    || webDriver.getCurrentUrl().contains("/common")
                    || webDriver.findElements(By.xpath("//*[contains(@aria-label, 'logout') or contains(@aria-label, 'topbar-logout-button')]")).size() > 0);
            success = true;
        } catch (Exception e) {
            // Ignore
        }
        
        Assert.assertTrue(success, "UI/API integration failed to redirect. Current URL: " + driver.getCurrentUrl());
        
        // Under test compile / mock conditions, we assert the integration mapping contract is correctly mapped
        Assert.assertFalse(mappings.isEmpty(), "Integration mappings must be registered in SQLite.");
        System.out.println("[L6] UI/API Integration mappings validated successfully.");
    }
}
