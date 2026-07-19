package testNG.PrimeCare;

import primecare.testing.base.BaseUiTest;
import primecare.testing.framework.planning.Models.ScreenDefinition;
import primecare.testing.framework.planning.Models.ScreenFunctionDefinition;
import primecare.testing.pages.DynamicScreen;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.framework.database.Repositories.FunctionRepository;
import primecare.testing.validation.TestLayer;
import org.openqa.selenium.By;
import org.testng.Assert;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;

import java.util.List;

@TestLayer(TestingLayerCode.L3)
public class L3FunctionalTest extends BaseUiTest {

    DynamicScreen page;

    @DataProvider(name = "functions")
    public Object[][] getFunctions() {
        ScreenDefinition loginScreen = ScreenRepository.getScreenByKey("login");
        List<ScreenFunctionDefinition> list = FunctionRepository.getFunctionsForScreen(loginScreen.screenId);
        Object[][] data = new Object[list.size()][1];
        for (int i = 0; i < list.size(); i++) {
            data[i][0] = list.get(i);
        }
        return data;
    }

    @Test(dataProvider = "functions", groups = {"l3"})
    public void verifyScreenFunction(ScreenFunctionDefinition func) {
        System.out.println("[L3] Testing function: " + func.functionKey + " (" + func.functionName + ")");
        
        // Open Login Screen
        driver.get(appProps.getProperty("login.url", "http://localhost:8080/login"));
        
        page = new DynamicScreen(driver, "login");
        String testUser = appProps.getProperty("username.admin", "clinic@primecare.com");
        String testPass = appProps.getProperty("password.admin", "Password123");

        if ("submit_valid_login".equals(func.functionKey)) {
            page.type("email_field", testUser);
            page.type("password_field", testPass);
            page.click("submit_button");

            // Verify redirect to success screen
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
            Assert.assertTrue(success, "Valid login did not redirect to success screen. Current URL: " + driver.getCurrentUrl());
        
        } else if ("submit_invalid_login".equals(func.functionKey)) {
            page.type("email_field", testUser);
            page.type("password_field", "WrongPassword");
            page.click("submit_button");

            // Verify we remain on login or see error
            boolean remainedOnLogin = driver.getCurrentUrl().contains("/login") || page.isVisible("email_field");
            Assert.assertTrue(remainedOnLogin, "Invalid login incorrectly redirected to: " + driver.getCurrentUrl());
        }
        System.out.println("[L3] Function verified successfully: " + func.functionKey);
    }
}
