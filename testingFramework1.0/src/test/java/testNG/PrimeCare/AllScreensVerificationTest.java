package testNG.PrimeCare;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import base.baseUserCredentials;

/**
 * AllScreensVerificationTest - Clean TestNG Test Class
 * All implementation and helper logic is delegated to AllScreensVerificationHelper.
 */
public class AllScreensVerificationTest extends baseUserCredentials {

    private final AllScreensVerificationHelper helper = new AllScreensVerificationHelper();

    public static class ScreenTestData extends AllScreensVerificationHelper.ScreenTestData {
        public ScreenTestData(int screenId, String screenName, String route, String requiredRole, String testEmail, String testPassword, String baseUrl) {
            super(screenId, screenName, route, requiredRole, testEmail, testPassword, baseUrl);
        }
    }

    @BeforeClass
    public void scanPageObjects() {
        helper.scanPageObjects();
    }

    @DataProvider(name = "activeScreens")
    public Object[][] getActiveScreens() {
        return helper.getActiveScreens();
    }

    @Test(dataProvider = "activeScreens")
    public void verifyScreenLayoutAndDOM(AllScreensVerificationHelper.ScreenTestData screen) {
        helper.executeVerification(screen, driver, this::clearSessionAndCookies, this::navigateToTargetPage);
    }
}
