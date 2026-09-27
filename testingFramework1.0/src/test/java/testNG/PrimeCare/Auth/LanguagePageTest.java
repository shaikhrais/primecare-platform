package testNG.PrimeCare.Auth;

import org.testng.Assert;
import org.testng.annotations.Test;
import pageobjects.primecare.ui.Auth1LanguageScreen;
import base.baseUserCredentials;

public class LanguagePageTest extends baseUserCredentials {

	Auth1LanguageScreen languagePage;
    @Test(description = "Verifies language selection functionality using the Auth1LanguageScreen POM")
    public void testLanguageSelection() throws InterruptedException {
        // Navigate to the language selection page
        driver.get(DEFAULT_BASE_URL + "/language?enable-semantics=true");
        waitForDocumentReady();
        enableSemantics();

        // Initialize Auth1LanguageScreen POM
        languagePage = new Auth1LanguageScreen();
        //Assert.assertTrue(languagePage.isLoaded(), "Language Selection page is not loaded");

        // Select English language
        languagePage.selectLanguage("en");
        languagePage.clickContinue();

        // Verify redirect to /login route
       // waitForDocumentReady();
        Assert.assertTrue(driver.getCurrentUrl().contains("/login"), "Selecting language did not navigate to /login. Current URL: " + driver.getCurrentUrl());
    }
}

