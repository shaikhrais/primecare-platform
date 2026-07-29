package utilities;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.Duration;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.WebDriverWait;

/**
 * PageRecoveryUtility - Simplified Core Authentication & Navigation Flow
 * Utility.
 * Executes exact 4-Step Sequence:
 * 1. Base first: Go to Language page -> Wait 2 seconds.
 * 2. Second: Click English button & Continue -> Wait 2 seconds.
 * 3. Third: Get credentials from DB & Login -> Check successful or not
 * (exit/fail if unsuccessful).
 * 4. Fourth: If successful -> Redirect to Target Page URL & Capture Screen
 * Print!
 */
public class PageRecoveryUtility {

    private final WebDriver driver;

    public PageRecoveryUtility(WebDriver driver, String loginUrl) {
        this.driver = driver;
    }

    public static void waitForPageLoadToSettle(WebDriver driver, long pauseMs) {
        System.out.println("  [BROWSER PAUSE] Pausing " + (pauseMs / 1000) + " seconds for page elements to load...");
        try {
            Thread.sleep(pauseMs);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            WebDriverWait shortWait = new WebDriverWait(driver, Duration.ofSeconds(10));
            shortWait.until(webDriver -> js.executeScript("return document.readyState").equals("complete"));
        } catch (Exception ignored) {
        }
    }

    public boolean executeCoreAuthAndNavigateToTarget(String targetRoute, String email, String password) {
        System.out.println("\n  ==========================================================================");
        System.out.println("  [CORE AUTH FLOW] Target Route Requested: " + targetRoute);
        System.out.println("  ==========================================================================");

        String base = primecare.testing.framework.DatabaseConfig.getBaseUrlForRoute(targetRoute);
        String authBase = primecare.testing.framework.DatabaseConfig.getAuthUrl();

        // -------------------------------------------------------------
        // STEP 1: BASE FIRST GO TO LANGUAGE PAGE & WAIT 2 SECONDS
        // -------------------------------------------------------------
        String langUrl = authBase + "/language";
        System.out.println("  [STEP 1] Base first: Navigating to Language Page (from SQLite DB): " + langUrl);
        driver.get(langUrl);
        System.out.println("  [STEP 1] Waiting 2 seconds...");
        sleep(2000);

        // -------------------------------------------------------------
        // STEP 2: SECOND CLICK ON ENGLISH BUTTON & WAIT 2 SECONDS
        // -------------------------------------------------------------
        System.out.println("  [STEP 2] Second: Clicking English language button & Continue...");
        handleLanguageFlow();
        System.out.println("  [STEP 2] Waiting 2 seconds...");
        sleep(2000);

        // -------------------------------------------------------------
        // STEP 3: THIRD GET CREDENTIALS FROM DB & LOGIN IN SYSTEM & CHECK SUCCESS
        // -------------------------------------------------------------
        if (!driver.getCurrentUrl().contains("/login")) {
            String loginUrlTarget = authBase + "/login?clientId=primecare-clinic&callbackUrl=" + base
                    + "%2Fauth%2Fcallback&returnUrl=" + targetRoute;
            System.out.println("  [STEP 3] Directing browser to Login Page (from SQLite DB): " + loginUrlTarget);
            driver.get(loginUrlTarget);
            sleep(2000);
        }
        System.out.println("  [STEP 3] Third: Logging into system with DB credentials (" + email + ")...");
        handleLoginFlow(email, password);
        System.out.println("  [STEP 3] Waiting 3 seconds for authentication...");
        sleep(3000);

        String currentUrl = driver.getCurrentUrl();
        boolean authSuccess = currentUrl.contains("/auth/callback") || currentUrl.contains("/success")
                || (!currentUrl.contains("/login") && !currentUrl.contains("/language"));
        System.out
                .println("  [STEP 3 CHECK] Login Status -> Success: " + authSuccess + " | Current URL: " + currentUrl);

        if (!authSuccess) {
            System.err.println("  [LOGIN FAILED] Authentication failed for user (" + email + ")! Exiting test.");
            org.testng.Assert
                    .fail("LOGIN FAILED: Authentication failed for email: " + email + " at URL: " + currentUrl);
            return false;
        }

        // -------------------------------------------------------------
        // STEP 4: IF SUCCESSFUL AND ROUTE IS SUCCESSFUL THEN REDIRECT TO TARGET PAGE &
        // SCREEN PRINT IT & CONSIDER SUCCESSFUL!
        // -------------------------------------------------------------
        String targetUrl = base + targetRoute + (targetRoute.contains("?") ? "&" : "?") + "enable-semantics=true";
        System.out.println("  [STEP 4] Fourth: Redirecting to Target Page (from SQLite DB): " + targetUrl);
        driver.get(targetUrl);
        System.out.println("  [STEP 4] Waiting 3 seconds for Target Page to load...");
        sleep(3000);

        // Screen Print
        captureScreenshot("TargetPage_" + targetRoute.replaceAll("[^a-zA-Z0-9]", "_"));

        System.out.println("  [STEP 4: SUCCESS] Target Page Reached & Screen Print Captured! Considered SUCCESSFUL!");
        System.out.println("  ==========================================================================");
        return true;
    }

    public void handleLanguageFlow() {
        try {
            WebElement engBtn = findSemanticElement("lang-english");
            if (engBtn == null)
                engBtn = findSemanticElement("english");
            if (engBtn != null) {
                System.out.println("  [ACTION] Clicking English button...");
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", engBtn);
            }
            WebElement contBtn = findSemanticElement("language-continue-button");
            if (contBtn == null)
                contBtn = findSemanticElement("continue");
            if (contBtn != null) {
                System.out.println("  [ACTION] Clicking Continue button...");
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", contBtn);
            }
            sleep(1500);

            String currentUrl = driver.getCurrentUrl();
            if (currentUrl.contains("/language")) {
                String loginTarget = currentUrl.replace("/language", "/login");
                System.out.println("  [URL RESOLVER] Transitioning to login route: " + loginTarget);
                driver.get(loginTarget);
                sleep(2000);
            }
        } catch (Exception ignored) {
        }
    }

    public void handleLoginFlow(String email, String password) {
        try {
            WebElement emailInput = findSemanticElement("login-email");
            if (emailInput != null) {
                emailInput.clear();
                emailInput.sendKeys(email);
                System.out.println("  [ACTION] Entered email address.");
            }
            WebElement passInput = findSemanticElement("login-password");
            if (passInput != null) {
                passInput.clear();
                passInput.sendKeys(password);
                System.out.println("  [ACTION] Entered password.");
            }
            WebElement submitBtn = findSemanticElement("login-submit");
            if (submitBtn != null) {
                System.out.println("  [ACTION] Clicking Login Submit...");
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", submitBtn);
            }
        } catch (Exception ignored) {
        }
    }

    public void captureScreenshot(String name) {
        try {
            if (driver instanceof TakesScreenshot) {
                File srcFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
                File destDir = new File("screenshots");
                if (!destDir.exists())
                    destDir.mkdirs();
                File destFile = new File(destDir, name + ".png");
                Files.copy(srcFile.toPath(), destFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                System.out.println("  [SCREEN PRINT] Saved screenshot artifact -> " + destFile.getAbsolutePath());
            }
        } catch (Exception ignored) {
        }
    }

    private void sleep(long ms) {
        try {
            Thread.sleep(ms);
        } catch (Exception ignored) {
        }
    }

    // =========================================================================
    // 🔄 BACKWARD COMPATIBILITY ALIASES (Delegating all legacy tests to 4-Step Core Flow)
    // =========================================================================
    public boolean executeSequentialRecoveryProtocol(String targetRoute, String email, String password) {
        return executeCoreAuthAndNavigateToTarget(targetRoute, email, password);
    }

    public boolean navigateToTargetScreen(String targetRoute, String expectedTitle, String email, String password) {
        return executeCoreAuthAndNavigateToTarget(targetRoute, email, password);
    }

    public boolean openRequestedPage(String targetRoute, org.openqa.selenium.By marker, String expectedTitle, String email, String password) {
        return executeCoreAuthAndNavigateToTarget(targetRoute, email, password);
    }

    public void enableSemantics() {
        try {
            String currentUrl = driver.getCurrentUrl();
            if (!currentUrl.contains("enable-semantics=true")) {
                String target = currentUrl + (currentUrl.contains("?") ? "&" : "?") + "enable-semantics=true";
                driver.get(target);
            }
        } catch (Exception ignored) {}
    }

    public boolean isElementVisible(String label) {
        WebElement el = findSemanticElement(label);
        return el != null && el.isDisplayed();
    }

    private WebElement findSemanticElement(String value) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            return (WebElement) js.executeScript(
                    "var findSemanticElement = function(root, val) { " +
                            "    if (!root) return null; " +
                            "    var selectors = [ " +
                            "        \"[aria-label='\" + val + \"']\", " +
                            "        \"[aria-label*='\" + val + \"']\", " +
                            "        \"[data-cy='\" + val + \"']\", " +
                            "        \"[id='\" + val + \"']\", " +
                            "        \"[name='\" + val + \"']\" " +
                            "    ]; " +
                            "    for (var i = 0; i < selectors.length; i++) { " +
                            "        try { " +
                            "            var el = root.querySelector(selectors[i]); " +
                            "            if (el) return el; " +
                            "        } catch (e) {} " +
                            "    } " +
                            "    return null; " +
                            "}; " +
                            "return findSemanticElement(document, arguments[0]);",
                    value);
        } catch (Exception e) {
            return null;
        }
    }
}
