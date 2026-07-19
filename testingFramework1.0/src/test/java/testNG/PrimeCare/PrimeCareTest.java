package testNG.PrimeCare;

import org.testng.annotations.Test;
import PageObjectsPrimeCare.ui.Auth1LanguageScreen;
import PageObjectsPrimeCare.ui.Auth2LoginScreen;
import PageObjectsPrimeCare.ui.Auth3SuccessScreen;
import base.baseUserCredentials;

public class PrimeCareTest extends baseUserCredentials {

    Auth1LanguageScreen languageScreen;
    Auth2LoginScreen loginScreen;
    Auth3SuccessScreen successScreen;

    @Test
    public void testPrimeCareUserJourney() throws InterruptedException {
        System.out.println("=== Starting PrimeCare Classic POM Test (Same Style as PointClickCare) ===");

        // Explicitly navigate to the start URL
        driver.get(DEFAULT_BASE_URL + "/language?enable-semantics=true");
        waitForDocumentReady();
        enableSemantics();

        // Step 1: Initialize Language Screen and select English conditionally
        if (driver.getCurrentUrl().contains("/language")) {
            languageScreen = new Auth1LanguageScreen();
            languageScreen.isLoaded();
            System.out.println("[STEP 1] Selecting English language...");
            languageScreen.selectLanguage("en");
            languageScreen.clickContinue();
        } else {
            System.out.println("[STEP 1] Bypassing language selection as browser is already redirected.");
        }
 
        // Step 2: Initialize Login Screen and log in
        loginScreen = new Auth2LoginScreen();
        loginScreen.isLoaded();
        System.out.println("[STEP 2] Logging in to PrimeCare Clinic with PSW role...");
        loginScreen.Login("qa.psw@test.primecare.local", "Test@12345");
        waitForLoginPageDisappearance();
 
        // Step 3: Verify Success (Dashboard) page load
        successScreen = new Auth3SuccessScreen();
        successScreen.isLoaded();
        System.out.println("[STEP 3] PrimeCare Dashboard verified successfully.");
    }
}
