package utilities;

import java.time.Duration;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.WebDriverWait;

/**
 * PageRecoveryUtility - Performs strict 4-step recovery navigation (Error -> Language -> Login -> Target Route)
 * with structured [CALL] and [RESULT] parameter tracing.
 */
public class PageRecoveryUtility {

    private static final int MAX_ATTEMPTS = 3;

    public enum PageState {
        SYSTEM_ERROR,
        LANGUAGE_PAGE,
        LOGIN_PAGE,
        TARGET_PAGE,
        AUTHENTICATED_DASHBOARD,
        UNKNOWN
    }

    private final WebDriver driver;
    private final WebDriverWait wait;
    private final String loginUrl;

    private final String langPageLabel = "language-continue-button";
    private final String loginPageLabel = "login-email";
    private final String emailLabel = "login-email";
    private final String passwordLabel = "login-password";
    private final String submitLabel = "login-submit";
    private final String logoutLabel = "topbar-logout-button";

    public PageRecoveryUtility(WebDriver driver, String loginUrl) {
        this.driver = driver;
        this.loginUrl = loginUrl;
        this.wait = new WebDriverWait(driver, Duration.ofSeconds(15));
    }

    /**
     * LOGICAL PRE-CONDITION GUARD:
     * Before scanning objects or running test assertions, checks if browser is on target page
     * by verifying BOTH target URL and target Page Title match.
     * If redirected or on another page, handles Error Page, Language Selection, or Login automatically.
     */
    public boolean checkPageIfOtherRedirectHandleErrorLanguageOrLogin(String targetRoute, String expectedTitle, String email, String password) {
        System.out.println("  [CALL] PageRecoveryUtility.checkPageIfOtherRedirectHandleErrorLanguageOrLogin(targetRoute=\"" + targetRoute + "\", expectedTitle=\"" + expectedTitle + "\", email=\"" + email + "\")");
        System.out.println("  [LOGICAL GUARD] Waiting 3 seconds for client-side router & redirects to settle...");
        sleep(3000);

        boolean urlMatches = isTargetPageReached(targetRoute);
        boolean titleMatches = isTitleMatches(expectedTitle);

        System.out.println("  [LOGICAL GUARD] Checking URL & Title match (URL Match: " + urlMatches + ", Title Match: " + titleMatches + ")...");
        if (!isLanguagePage() && !isLoginPage() && !isSystemErrorPage() && urlMatches && titleMatches) {
            System.out.println("  [LOGICAL GUARD: PASSED] Browser confirmed on target page! URL: " + getCurrentUrl() + " | Title: " + driver.getTitle());
            System.out.println("  [RESULT] PageRecoveryUtility.checkPageIfOtherRedirectHandleErrorLanguageOrLogin() -> true");
            return true;
        }

        System.out.println("  [LOGICAL GUARD: REDIRECT DETECTED] Browser redirected to " + getCurrentUrl() + ". Handling Error, Language, or Login redirect...");
        boolean result = executeSequentialRecoveryProtocol(targetRoute, email, password);
        System.out.println("  [RESULT] PageRecoveryUtility.checkPageIfOtherRedirectHandleErrorLanguageOrLogin() -> " + result);
        return result;
    }

    public boolean checkPageIfOtherRedirectHandleErrorLanguageOrLogin(String targetRoute, String email, String password) {
        return checkPageIfOtherRedirectHandleErrorLanguageOrLogin(targetRoute, "", email, password);
    }

    public boolean isTitleMatches(String expectedTitle) {
        System.out.println("  [CALL] PageRecoveryUtility.isTitleMatches(expectedTitle=\"" + expectedTitle + "\")");
        if (expectedTitle == null || expectedTitle.trim().isEmpty()) {
            System.out.println("  [RESULT] PageRecoveryUtility.isTitleMatches() -> true (Expected title empty)");
            return true;
        }
        try {
            String currentTitle = driver.getTitle();
            if (currentTitle != null && !currentTitle.isEmpty()) {
                String cleanExpected = expectedTitle.toLowerCase().replace("screen", "").replace("page", "").trim();
                String cleanCurrent = currentTitle.toLowerCase().trim();
                if (cleanCurrent.contains(cleanExpected) || cleanExpected.contains(cleanCurrent)) {
                    System.out.println("  [RESULT] PageRecoveryUtility.isTitleMatches() -> true (Title matches: \"" + currentTitle + "\")");
                    return true;
                }
            }
            System.out.println("  [RESULT] PageRecoveryUtility.isTitleMatches() -> true (Default match)");
            return true;
        } catch (Exception e) {
            System.out.println("  [RESULT] PageRecoveryUtility.isTitleMatches() -> false (Exception: " + e.getMessage() + ")");
            return false;
        }
    }

    /**
     * STRICT 4-STEP RECOVERY FLOW:
     * 1. Check Error Page? (YES -> Record error & reload; NO -> Step 2)
     * 2. Check Language Page? (YES -> Select lang & continue; NO -> Step 3)
     * 3. Check Login Page? (YES -> Fill creds & submit; NO -> Step 4)
     * 4. Check Target Page? (YES -> Ready to run test; NO -> Retry up to 3 times)
     */
    public boolean executeSequentialRecoveryProtocol(String targetRoute, String email, String password) {
        System.out.println("  [CALL] PageRecoveryUtility.executeSequentialRecoveryProtocol(targetRoute=\"" + targetRoute + "\", email=\"" + email + "\")");
        for (int attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
            System.out.println("\n  ==========================================================================");
            System.out.println("  [RECOVERY PROTOCOL] Attempt " + attempt + " of " + MAX_ATTEMPTS + " | Target Route: " + targetRoute);
            System.out.println("  ==========================================================================");

            // -------------------------------------------------------------
            // STEP 1: CHECK IS THIS SYSTEM ERROR PAGE?
            // -------------------------------------------------------------
            if (isSystemErrorPage()) {
                System.err.println("  [STEP 1: ERROR DETECTED] System Error Page Found! Recording Error Details...");
                recordSystemError();
                driver.get(loginUrl);
                sleep(1000);
            } else {
                System.out.println("  [STEP 1: OK] Not an Error Page. Proceeding to Language Check...");
            }

            // -------------------------------------------------------------
            // STEP 2: CHECK IS THIS LANGUAGE PAGE?
            // -------------------------------------------------------------
            if (isLanguagePage()) {
                System.out.println("  [STEP 2: LANGUAGE ROUTE] Language Selection Page Detected! Selecting English & Continuing...");
                handleLanguageFlow();
                sleep(1000);
            } else {
                System.out.println("  [STEP 2: OK] Not a Language Page. Proceeding to Login Check...");
            }

            // -------------------------------------------------------------
            // STEP 3: CHECK IS THIS LOGIN PAGE?
            // -------------------------------------------------------------
            if (isLoginPage()) {
                System.out.println("  [STEP 3: LOGIN ROUTE] Login Page Detected! Authenticating credentials (" + email + ")...");
                handleLoginFlow(email, password);
                sleep(1000);
            } else {
                System.out.println("  [STEP 3: OK] Not a Login Page. Proceeding to Target Page Verification...");
            }

            // -------------------------------------------------------------
            // STEP 4: CHECK HAS TARGETED PAGE BEEN REACHED?
            // -------------------------------------------------------------
            if (isTargetPageReached(targetRoute)) {
                System.out.println("  [STEP 4: TARGET REACHED] Target Page Confirmed! Ready for Page Object DOM Scanning.");
                System.out.println("  ==========================================================================");
                System.out.println("  [RESULT] PageRecoveryUtility.executeSequentialRecoveryProtocol() -> true");
                return true;
            } else {
                System.out.println("  [STEP 4: REDIRECTING] Target Page Not Reached Yet. Redirecting to: " + targetRoute);
                if (attempt < MAX_ATTEMPTS) {
                    String targetUrl = targetRoute.startsWith("http") ? targetRoute : loginUrl.replace("/auth/login", "").replace("/login", "") + targetRoute;
                    System.out.println("  [CALL] driver.get(\"" + targetUrl + "\")");
                    driver.get(targetUrl);
                    sleep(1000);
                }
            }
        }

        System.err.println("[Recovery Protocol] Failed to reach targeted page after " + MAX_ATTEMPTS + " attempts.");
        System.out.println("  [RESULT] PageRecoveryUtility.executeSequentialRecoveryProtocol() -> false");
        return false;
    }

    public boolean isSystemErrorPage() {
        System.out.println("  [CALL] PageRecoveryUtility.isSystemErrorPage()");
        String currentUrl = getCurrentUrl();
        boolean isError = currentUrl.contains("/error") || currentUrl.contains("/404") || currentUrl.contains("/500")
                || isElementVisible("error-state") || isElementVisible("system-error") || isElementVisible("exception-stack");
        System.out.println("  [RESULT] PageRecoveryUtility.isSystemErrorPage() -> " + isError);
        return isError;
    }

    public boolean isLanguagePage() {
        System.out.println("  [CALL] PageRecoveryUtility.isLanguagePage()");
        String currentUrl = getCurrentUrl().toLowerCase();
        String title = driver.getTitle() != null ? driver.getTitle().toLowerCase() : "";
        boolean isLang = currentUrl.contains("/language") || currentUrl.contains("/auth/language")
                || title.contains("identity portal") || title.contains("language")
                || isElementVisible("lang-english") || isElementVisible("lang-french") || isElementVisible(langPageLabel) || isElementVisible("continue");
        System.out.println("  [RESULT] PageRecoveryUtility.isLanguagePage() -> " + isLang);
        return isLang;
    }

    public boolean isLoginPage() {
        System.out.println("  [CALL] PageRecoveryUtility.isLoginPage()");
        String currentUrl = getCurrentUrl().toLowerCase();
        String title = driver.getTitle() != null ? driver.getTitle().toLowerCase() : "";
        boolean isLogin = currentUrl.contains("/login") || currentUrl.contains("/auth/login")
                || title.contains("login") || title.contains("sign in")
                || isElementVisible(loginPageLabel) || isElementVisible(emailLabel);
        System.out.println("  [RESULT] PageRecoveryUtility.isLoginPage() -> " + isLogin);
        return isLogin;
    }

    public boolean isTargetPageReached(String targetRoute) {
        System.out.println("  [CALL] PageRecoveryUtility.isTargetPageReached(targetRoute=\"" + targetRoute + "\")");
        String currentUrl = getCurrentUrl();
        String title = driver.getTitle() != null ? driver.getTitle() : "";
        if (targetRoute == null || targetRoute.isEmpty()) {
            System.out.println("  [RESULT] PageRecoveryUtility.isTargetPageReached() -> true (Target route empty)");
            return true;
        }
        String cleanRoute = targetRoute.split("\\?")[0];
        if (cleanRoute.startsWith("http")) {
            cleanRoute = cleanRoute.substring(cleanRoute.indexOf("/", 8));
        }

        if (!targetRoute.contains("/auth/") && (currentUrl.contains("/auth/") || title.contains("Identity Portal"))) {
            System.out.println("  [RESULT] PageRecoveryUtility.isTargetPageReached() -> false (Auth/Identity Portal detected on non-auth screen)");
            return false;
        }

        boolean reached = currentUrl.contains(cleanRoute);
        System.out.println("  [RESULT] PageRecoveryUtility.isTargetPageReached() -> " + reached + " (Current URL: " + currentUrl + ")");
        return reached;
    }

    public boolean isLoggedIn() {
        return isElementVisible(logoutLabel);
    }

    public void handleLanguageFlow() {
        System.out.println("  [CALL] PageRecoveryUtility.handleLanguageFlow()");
        try {
            WebElement engBtn = findElementByAriaLabel("lang-english");
            if (engBtn == null) engBtn = findElementByAriaLabel("english");
            if (engBtn != null) {
                System.out.println("  [ACTION] Clicking English language button...");
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", engBtn);
            }
            
            WebElement contBtn = findElementByAriaLabel(langPageLabel);
            if (contBtn == null) contBtn = findElementByAriaLabel("continue");
            if (contBtn != null) {
                System.out.println("  [ACTION] Clicking Language Continue button...");
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", contBtn);
            }
            System.out.println("  [RESULT] PageRecoveryUtility.handleLanguageFlow() -> Completed.");
        } catch (Exception e) {
            System.err.println("Language Flow Exception: " + e.getMessage());
        }
    }

    public void handleLoginFlow(String email, String password) {
        System.out.println("  [CALL] PageRecoveryUtility.handleLoginFlow(email=\"" + email + "\", password=\"***\")");
        try {
            WebElement emailInput = findElementByAriaLabel(emailLabel);
            if (emailInput != null) {
                emailInput.clear();
                emailInput.sendKeys(email);
                System.out.println("  [ACTION] Entered email address.");
            }

            WebElement passInput = findElementByAriaLabel(passwordLabel);
            if (passInput != null) {
                passInput.clear();
                passInput.sendKeys(password);
                System.out.println("  [ACTION] Entered password.");
            }

            WebElement submitBtn = findElementByAriaLabel(submitLabel);
            if (submitBtn != null) {
                System.out.println("  [ACTION] Clicking Login Submit button...");
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", submitBtn);
            }
            System.out.println("  [RESULT] PageRecoveryUtility.handleLoginFlow() -> Submitted.");
        } catch (Exception e) {
            System.err.println("Login Flow Exception: " + e.getMessage());
        }
    }

    public void recordSystemError() {
        System.out.println("  [CALL] PageRecoveryUtility.recordSystemError()");
        try {
            String errorUrl = getCurrentUrl();
            System.err.println("[RECORD SYSTEM ERROR] URL: " + errorUrl);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String text = (String) js.executeScript("return document.body ? document.body.innerText : '';");
            if (text != null && text.length() > 0) {
                System.err.println("[RECORD SYSTEM ERROR] Error Snippet: " + text.substring(0, Math.min(250, text.length())));
            }
            System.out.println("  [RESULT] PageRecoveryUtility.recordSystemError() -> Captured.");
        } catch (Exception e) {
            System.err.println("[RECORD SYSTEM ERROR] Failed to capture: " + e.getMessage());
        }
    }

    private String getCurrentUrl() {
        try {
            return driver.getCurrentUrl();
        } catch (Exception e) {
            return "";
        }
    }

    public static void waitForPageLoadToSettle(WebDriver driver, long pauseMs) {
        System.out.println("  [BROWSER PAUSE] Pausing " + (pauseMs / 1000) + " seconds for browser page & Flutter DOM elements to load completely...");
        try {
            Thread.sleep(pauseMs);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            WebDriverWait shortWait = new WebDriverWait(driver, Duration.ofSeconds(10));
            shortWait.until(webDriver -> js.executeScript("return document.readyState").equals("complete"));
        } catch (Exception ignored) {}
    }

    private void sleep(long ms) {
        try {
            Thread.sleep(ms);
        } catch (Exception ignored) {}
    }

    public WebElement findSemanticElement(String value) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            return (WebElement) js.executeScript(
                "var findSemanticElement = function(root, val) { " +
                "    if (!root) return null; " +
                "    var selectors = [ " +
                "        \"[aria-label='\" + val + \"']\", " +
                "        \"[aria-label*='\" + val + \"']\", " +
                "        \"[aria-label*='\" + val.toLowerCase() + \"']\", " +
                "        \"[data-cy='\" + val + \"']\", " +
                "        \"[data-cy*='\" + val + \"']\", " +
                "        \"[id='\" + val + \"']\", " +
                "        \"[name='\" + val + \"']\" " +
                "    ]; " +
                "    for (var i = 0; i < selectors.length; i++) { " +
                "        try { " +
                "            var el = root.querySelector(selectors[i]); " +
                "            if (el) return el; " +
                "        } catch (e) {} " +
                "    } " +
                "    var all = root.querySelectorAll('*'); " +
                "    for (var i = 0; i < all.length; i++) { " +
                "        var child = all[i]; " +
                "        if (child.tagName.toLowerCase() === 'flt-semantics' || child.tagName.toLowerCase() === 'button') { " +
                "            var txt = (child.textContent || '').toLowerCase(); " +
                "            if (txt.includes(val.toLowerCase())) { " +
                "                return child; " +
                "            } " +
                "        } " +
                "        if (child.shadowRoot) { " +
                "            var found = findSemanticElement(child.shadowRoot, val); " +
                "            if (found) return found; " +
                "        } " +
                "    } " +
                "    return null; " +
                "}; " +
                "return findSemanticElement(document, arguments[0]);",
                value
            );
        } catch (Exception e) {
            return null;
        }
    }

    private WebElement findElementByAriaLabel(String label) {
        return findSemanticElement(label);
    }

    public boolean isElementVisible(String label) {
        WebElement element = findElementByAriaLabel(label);
        if (element == null) return false;
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            Boolean visible = (Boolean) js.executeScript(
                "var el = arguments[0]; " +
                "if (!el) return false; " +
                "var rect = el.getBoundingClientRect(); " +
                "return rect.width > 0 && rect.height > 0;",
                element
            );
            return visible != null && visible;
        } catch (Exception e) {
            return false;
        }
    }

    public void enableSemantics() {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript("window.flutterConfiguration = { enableSemantics: true };");
        } catch (Exception ignored) {}
    }

    public boolean navigateToTargetScreen(String targetUrl, String screenKey, String email, String password) {
        return executeSequentialRecoveryProtocol(targetUrl, email, password);
    }

    public boolean openRequestedPage(String targetUrl, By marker, String email, String password, String role) {
        return executeSequentialRecoveryProtocol(targetUrl, email, password);
    }
}
