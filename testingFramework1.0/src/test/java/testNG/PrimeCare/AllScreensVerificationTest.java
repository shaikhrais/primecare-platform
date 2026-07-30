package testNG.PrimeCare;

import org.testng.annotations.BeforeClass;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import base.baseUserCredentials;

/**
 * ====================================================================================
 * 🧪 PRIMECARE PLATFORM - ALL SCREENS VERIFICATION TEST (AllScreensVerificationTest.java)
 * ====================================================================================
 * 
 * OVERVIEW:
 * High-level TestNG test definition class. Implements Clean Architecture principles by
 * separating TestNG annotations (@BeforeClass, @DataProvider, @Test) from internal
 * implementation logic. All scanning, database fetching, recovery navigation, and
 * page verification logic is cleanly encapsulated inside AllScreensVerificationHelper.
 * 
 * EXECUTION FLOW:
 * 1. @BeforeClass scanPageObjects()   -> Calls helper.scanPageObjects() to map POM classes.
 * 2. @DataProvider getActiveScreens() -> Calls helper.getActiveScreens() to fetch screens from DB.
 * 3. @Test verifyScreenLayoutAndDOM() -> Calls helper.executeVerification() for each screen.
 * 4. main(String[] args)             -> Allows direct right-click execution as Java Application.
 * ====================================================================================
 */
public class AllScreensVerificationTest extends baseUserCredentials {

    // Helper instance holding all core scanning, data loading, and execution logic
    private final AllScreensVerificationHelper helper = new AllScreensVerificationHelper();

    /**
     * Inner data model representing screen test parameter data.
     */
    public static class ScreenTestData extends AllScreensVerificationHelper.ScreenTestData {
        public ScreenTestData(int screenId, String screenName, String route, String requiredRole, String testEmail, String testPassword, String baseUrl) {
            super(screenId, screenName, route, requiredRole, testEmail, testPassword, baseUrl);
        }
    }

    /**
     * Step 1: Scan Page Objects directory before test execution.
     */
    @BeforeClass
    public void scanPageObjects() {
        System.out.println("\n--- [STEP 1/3] INITIALIZING PAGE OBJECT SCANNER ---");
        helper.scanPageObjects();
    }

    /**
     * Step 2: DataProvider supplying active screens to the test method.
     */
    @DataProvider(name = "activeScreens")
    public Object[][] getActiveScreens() {
        System.out.println("\n--- [STEP 2/3] FETCHING ACTIVE SCREENS FROM GOVERNANCE DATABASE ---");
        return helper.getActiveScreens();
    }

    /**
     * Step 3: Test method executed for each screen supplied by DataProvider.
     */
    @Test(dataProvider = "activeScreens")
    public void verifyScreenLayoutAndDOM(AllScreensVerificationHelper.ScreenTestData screen) {
        verifyNavigationProtocol(screen.screenId, screen.screenName, screen.route);
        helper.executeVerification(screen, driver, null, null);
    }

    /**
     * Main method allowing direct right-click execution as Java Application in Eclipse.
     */
    public static void main(String[] args) {
        System.out.println("==========================================================================");
        System.out.println(" 🚀 LAUNCHING ALL SCREENS VERIFICATION TEST AS JAVA APPLICATION");
        System.out.println("==========================================================================");

        org.testng.TestNG testng = new org.testng.TestNG();
        testng.setTestClasses(new Class[] { AllScreensVerificationTest.class });
        testng.addListener(new base.TestNGVerificationListener());

        System.out.println("[MAIN] Executing TestNG test suite programmatically...");
        testng.run();

        System.out.println("==========================================================================");
        System.out.println(" ✅ ALL SCREENS VERIFICATION RUN COMPLETED!");
        System.out.println("==========================================================================");
    }
}
