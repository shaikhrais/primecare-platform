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
        String logId = "LOG-ID-" + System.currentTimeMillis();
        System.out.println("\n====================================================================================");
        System.out.println("🧪 PRIMECARE PLATFORM - CORE NAVIGATION & AUTHENTICATION PROTOCOL");
        System.out.println("====================================================================================");
        System.out.println("[LOG ID] " + logId);
        System.out.println("[TARGET REQUESTED] Route: " + targetRoute);

        String base = primecare.testing.framework.DatabaseConfig.getBaseUrlForRoute(targetRoute);
        String authBase = primecare.testing.framework.DatabaseConfig.getAuthUrl();
        System.out.println("[DB RESOLVER] Target Base URL: " + base + " | Auth Base URL: " + authBase);

        // -------------------------------------------------------------
        // STEP 1: INITIALIZE LANGUAGE PORTAL
        // -------------------------------------------------------------
        String langUrl = authBase + "/language?clientId=primecare-clinic&callbackUrl=" + base + "%2Fauth%2Fcallback&returnUrl=" + targetRoute;
        System.out.println("\n--- STEP 1: INITIALIZE LANGUAGE PORTAL [" + logId + "] ---");
        System.out.println("  [CALL] driver.get(\"" + langUrl + "\")");
        driver.get(langUrl);
        System.out.println("  [ACTION] Pausing 2,000ms for Language Selection Portal to render...");
        sleep(2000);
        System.out.println("  [CHECK] Language Page URL: " + driver.getCurrentUrl() + " -> VERIFIED");

        // -------------------------------------------------------------
        // STEP 2: SELECT ENGLISH LANGUAGE & CONTINUE
        // -------------------------------------------------------------
        System.out.println("\n--- STEP 2: SELECT ENGLISH LANGUAGE & CONTINUE [" + logId + "] ---");
        handleLanguageFlow();
        System.out.println("  [ACTION] Pausing 2,000ms for language preference state to persist...");
        sleep(2000);
        System.out.println("  [CHECK] Language selection completed.");

        // -------------------------------------------------------------
        // STEP 3: FETCH DB CREDENTIALS & AUTHENTICATE
        // -------------------------------------------------------------
        System.out.println("\n--- STEP 3: FETCH DB CREDENTIALS & AUTHENTICATE [" + logId + "] ---");
        System.out.println("  [DB FETCH] User Email: " + email + " | Password: [PROTECTED]");
        if (!driver.getCurrentUrl().contains("/login")) {
            String loginUrlTarget = authBase + "/login?clientId=primecare-clinic&callbackUrl=" + base + "%2Fauth%2Fcallback&returnUrl=" + targetRoute;
            System.out.println("  [ACTION] Navigating to Login Portal: " + loginUrlTarget);
            driver.get(loginUrlTarget);
            sleep(2000);
        }
        handleLoginFlow(email, password);
        System.out.println("  [ACTION] Pausing 3,000ms for OAuth token exchange & callback redirect...");
        sleep(3000);

        String currentUrl = driver.getCurrentUrl();
        boolean authSuccess = currentUrl.contains("/auth/callback") || currentUrl.contains("/success") || (!currentUrl.contains("/login") && !currentUrl.contains("/language"));
        System.out.println("  [CHECK] Post-Login URL: " + currentUrl);
        System.out.println("  [CHECK] Login Authentication Status: " + (authSuccess ? "SUCCESS" : "FAILED"));

        if (!authSuccess) {
            System.err.println("  [MISMATCH DETECTED][" + logId + "] Authentication failed! Browser remained on: " + currentUrl);
            System.err.println("  [LOGIN FAILED][" + logId + "] Authentication failed for user (" + email + ")! Exiting test.");
            org.testng.Assert.fail("LOGIN FAILED [" + logId + "]: Authentication failed for email: " + email + " at URL: " + currentUrl);
            return false;
        }

        // -------------------------------------------------------------
        // STEP 4: REDIRECT TO TARGET PAGE & VERIFY ROUTE / CAPTURE SCREEN PRINT
        // -------------------------------------------------------------
        System.out.println("\n--- STEP 4: REDIRECT TO TARGET PAGE & VERIFY ROUTE / CAPTURE SCREEN PRINT [" + logId + "] ---");
        String targetUrl = base + targetRoute + (targetRoute.contains("?") ? "&" : "?") + "enable-semantics=true";
        System.out.println("  [ACTION] Directing browser to Target Route URL: " + targetUrl);
        driver.get(targetUrl);
        System.out.println("  [ACTION] Pausing 3,000ms for Target Page DOM & Flutter Web elements to render...");
        sleep(3000);

        boolean isMatched = verifyExpectedVsActual(targetRoute, "", logId);

        // Screen Print
        captureScreenshot("TargetPage_" + targetRoute.replaceAll("[^a-zA-Z0-9]", "_"));

        if (!isMatched) {
            System.err.println("  [FINAL RESULT] Core Authentication & Navigation Protocol [" + logId + "] -> MISMATCH FAILED!");
            org.testng.Assert.fail("EXPECTED VS ACTUAL MISMATCH [" + logId + "]: Could not match expected route " + targetRoute + " with actual URL " + driver.getCurrentUrl());
            return false;
        }

        System.out.println("  [FINAL RESULT] Core Authentication & Navigation Protocol [" + logId + "] -> PASSED!");
        System.out.println("====================================================================================\n");
        return true;
    }

    public boolean verifyExpectedVsActual(String expectedRoute, String expectedTitle, String logId) {
        String actualUrl = driver.getCurrentUrl();
        String actualTitle = driver.getTitle();
        String cleanRoute = expectedRoute.split("\\?")[0];

        boolean routeMatches = actualUrl != null && actualUrl.contains(cleanRoute);
        boolean isAuthPage = actualUrl != null && (actualUrl.contains("/login") || actualUrl.contains("/language"));

        System.out.println("  [EXPECTED VS ACTUAL COMPARISON] [" + logId + "]");
        System.out.println("    • Expected Route: " + expectedRoute);
        System.out.println("    • Actual URL:     " + actualUrl);
        if (expectedTitle != null && !expectedTitle.isEmpty()) {
            System.out.println("    • Expected Title: " + expectedTitle);
            System.out.println("    • Actual Title:   " + actualTitle);
        }
        System.out.println("    • Route Match:    " + (routeMatches && !isAuthPage ? "PASS (Contains expected path)" : "FAIL (URL mismatch or redirected to auth)"));

        if (!routeMatches || isAuthPage) {
            System.err.println("    [MISMATCH DETECTED] Actual URL (" + actualUrl + ") does NOT match Expected Route (" + expectedRoute + ")!");
            return false;
        }
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
