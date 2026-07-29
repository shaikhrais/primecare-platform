// Fresh compilation touch: 2026-07-17T00:51:00Z
package testNG.PrimeCare;

import primecare.testing.framework.*;
import static primecare.testing.framework.Models.*;
import static primecare.testing.framework.Repositories.*;

import org.testng.annotations.Test;
import pageobjects.primecare.ui.Clinic61PswDashboardScreen;
import base.baseUserCredentials;

public class PswDashboardTest extends baseUserCredentials {

    Clinic61PswDashboardScreen pswDashboardScreen;

    @Test
    public void testPswDashboardUserJourney() throws InterruptedException {
        System.out.println("=== Starting PrimeCare PSW Dashboard POM Test ===");

        String portalUrl = "https://primecare-clinic.pages.dev/offices/clinical/roles/psw/dashboard?enable-semantics=true";
        String email = "qa.psw@test.primecare.local";
        String password = "Test@12345";

        redirectToRequestedPage(
            portalUrl,
            "Clinic61PswDashboardScreen",
            email,
            password,
            this::submitLoginCredentials
        );

        // Initialize and verify loading (all steps are self-contained inside the POM!)
        pswDashboardScreen = new Clinic61PswDashboardScreen();
        pswDashboardScreen.isLoaded();
        pswDashboardScreen.verifyAllComponentsAccessible();
        
        System.out.println("[SUCCESS] PSW Dashboard test execution completed.");
    }
}

