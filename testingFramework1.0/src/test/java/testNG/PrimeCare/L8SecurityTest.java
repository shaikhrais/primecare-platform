package testNG.PrimeCare;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import primecare.testing.base.BaseUiTest;
import primecare.testing.models.TestingLayerCode;
import primecare.testing.validation.TestLayer;
import org.openqa.selenium.By;
import org.testng.Assert;
import org.testng.annotations.Test;

@TestLayer(TestingLayerCode.L8)
public class L8SecurityTest extends BaseUiTest {

    @Test(groups = {"l8", "security"})
    public void verifyAnonymousUserBlockedFromProtectedPage() {
        System.out.println("[L8] Verifying security rules block unauthenticated access...");

        String successUrl = appProps.getProperty("APP_BASE_URL", "http://localhost:8080") + "/success";
        driver.get(successUrl);

        // Wait up to 10 seconds for redirection
        org.openqa.selenium.support.ui.WebDriverWait shortWait = new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(10));
        boolean redirected = false;
        try {
            shortWait.until(webDriver -> webDriver.getCurrentUrl().contains("/login") 
                    || webDriver.getCurrentUrl().contains("/sso-redirect")
                    || webDriver.findElements(By.xpath("//*[contains(@aria-label, 'login-email')]")).size() > 0);
            redirected = true;
        } catch (Exception e) {
            // Ignore
        }
                
        Assert.assertTrue(redirected, "Security failure: Anonymous user was not redirected to Login page when opening protected page! Current URL: " + driver.getCurrentUrl());
        System.out.println("[L8] Security block verified successfully.");
    }
}
