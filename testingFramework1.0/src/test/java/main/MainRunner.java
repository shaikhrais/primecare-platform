package main;

import testNG.PrimeCare.AllScreensVerificationTest;
import base.TestNGVerificationListener;
import org.testng.TestNG;

/**
 * ====================================================================================
 * 🚀 PRIMECARE PLATFORM - STANDALONE MAIN JAVA RUNNER (MainRunner.java)
 * ====================================================================================
 * 
 * PURPOSE:
 * Provides a single, clean Java entry point (public static void main) that allows developers
 * and QA engineers to execute the entire PrimeCare automated screen verification suite directly
 * as a standard Java Application from Eclipse IDE (Right Click -> Run As -> Java Application)
 * or command line without requiring manual TestNG XML plugin setup.
 * 
 * LOGICAL EXECUTION FLOW:
 * ------------------------------------------------------------------------------------
 * 1. Initialize Programmatic TestNG Engine (TestNG testng = new TestNG()).
 * 2. Register Target Test Class (AllScreensVerificationTest.class).
 * 3. Attach Executive Verification Listener (TestNGVerificationListener) for generating:
 *    - Interactive HTML Executive Dashboard (PrimeCare_Executive_Dashboard.html)
 *    - Excel Summary Report (.xlsx)
 *    - SQLite Database Persistence (governance.db)
 * 4. Trigger Programmatic Execution (testng.run()).
 * ====================================================================================
 */
public class MainRunner {

    public static void main(String[] args) {
        System.out.println("==========================================================================");
        System.out.println(" 🚀 PRIMECARE PLATFORM - STANDALONE MAIN JAVA TEST RUNNER");
        System.out.println("==========================================================================");

        try {
            System.out.println("[STEP 1/4] Initializing Programmatic TestNG Test Engine...");
            TestNG testng = new TestNG();

            System.out.println("[STEP 2/4] Registering Test Suite Class: AllScreensVerificationTest.class");
            testng.setTestClasses(new Class[] { AllScreensVerificationTest.class });

            System.out.println("[STEP 3/4] Attaching Executive Listener (HTML Dashboard, Excel & SQLite)...");
            testng.addListener(new TestNGVerificationListener());

            System.out.println("[STEP 4/4] Launching Automated Verification Suite Execution...");
            System.out.println("--------------------------------------------------------------------------");
            testng.run();

            System.out.println("--------------------------------------------------------------------------");
            System.out.println(" ✅ ALL VERIFICATION TASKS COMPLETED SUCCESSFULLY!");
            System.out.println(" 📊 HTML Dashboard: test-output/primecare-verification/PrimeCare_Executive_Dashboard.html");
            System.out.println("==========================================================================");
        } catch (Exception e) {
            System.err.println(" ❌ FATAL ERROR DURING MAIN RUNNER EXECUTION: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
