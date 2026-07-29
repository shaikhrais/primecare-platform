package utilities;

import java.time.Duration;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

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
     * Before scanning objects or running test assertions, checks if browser is on target page.
     * If redirected or on another page, handles Error Page, Language Selection, or Login automatically.
     */
    public boolean checkPageIfOtherRedirectHandleErrorLanguageOrLogin(String targetRoute, String email, String password) {
        System.out.println("  [LOGICAL GUARD] Waiting 3 seconds for client-side router & redirects to settle...");
        sleep(3000);

        System.out.println("  [LOGICAL GUARD] Checking browser page location after 3s delay...");
        if (!isLanguagePage() && !isLoginPage() && !isSystemErrorPage() && isTargetPageReached(targetRoute)) {
            System.out.println("  [LOGICAL GUARD: PASSED] Browser is confirmed on target page: " + targetRoute);
            return true;
        }

        System.out.println("  [LOGICAL GUARD: REDIRECT DETECTED] Browser redirected to " + getCurrentUrl() + ". Handling Error, Language, or Login redirect...");
        return executeSequentialRecoveryProtocol(targetRoute, email, password);
    }

    /**
     * STRICT 4-STEP RECOVERY FLOW:
     * 1. Check Error Page? (YES -> Record error & reload; NO -> Step 2)
     * 2. Check Language Page? (YES -> Select lang & continue; NO -> Step 3)
     * 3. Check Login Page? (YES -> Fill creds & submit; NO -> Step 4)
     * 4. Check Target Page? (YES -> Ready to run test; NO -> Retry up to 3 times)
     */
    public boolean executeSequentialRecoveryProtocol(String targetRoute, String email, String password) {
        for (int attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
            System.out.println("\n[Recovery Protocol] ATTEMPT " + attempt + " of " + MAX_ATTEMPTS + " | Route: " + targetRoute);

            // -------------------------------------------------------------
            // STEP 1: CHECK IS THIS SYSTEM ERROR PAGE?
            // -------------------------------------------------------------
            if (isSystemErrorPage()) {
                System.err.println("  [Step 1: YES] System Error Page Detected! Recording Error...");
                recordSystemError();
                driver.get(loginUrl);
                sleep(1000);
            } else {
                System.out.println("  [Step 1: NO] Not an Error Page. Proceeding to Step 2...");
            }

            // -------------------------------------------------------------
            // STEP 2: CHECK IS THIS LANGUAGE PAGE?
            // -------------------------------------------------------------
            if (isLanguagePage()) {
                System.out.println("  [Step 2: YES] Language Page Detected! Running Language Flow...");
                handleLanguageFlow();
                sleep(1000);
            } else {
                System.out.println("  [Step 2: NO] Not a Language Page. Proceeding to Step 3...");
            }

            // -------------------------------------------------------------
            // STEP 3: CHECK IS THIS LOGIN PAGE?
            // -------------------------------------------------------------
            if (isLoginPage()) {
                System.out.println("  [Step 3: YES] Login Page Detected! Running Login Flow...");
                handleLoginFlow(email, password);
                sleep(1000);
            } else {
                System.out.println("  [Step 3: NO] Not a Login Page. Proceeding to Step 4...");
            }

            // -------------------------------------------------------------
            // STEP 4: CHECK HAS TARGETED PAGE BEEN REACHED?
            // -------------------------------------------------------------
            if (isTargetPageReached(targetRoute)) {
                System.out.println("  [Step 4: YES] Targeted Page Reached Successfully! Ready to Run Test.");
                return true;
            } else {
                System.out.println("  [Step 4: NO] Target Page Not Reached Yet. Actual URL: " + getCurrentUrl());
                // Force navigation to target route if attempt < MAX
                if (attempt < MAX_ATTEMPTS) {
                    String targetUrl = targetRoute.startsWith("http") ? targetRoute : loginUrl.replace("/login", "") + targetRoute;
                    driver.get(targetUrl);
                    sleep(1000);
                }
            }
        }

        System.err.println("[Recovery Protocol] Failed to reach targeted page after " + MAX_ATTEMPTS + " attempts.");
        return false;
    }

    public boolean isSystemErrorPage() {
        String currentUrl = getCurrentUrl();
        if (currentUrl.contains("/error") || currentUrl.contains("/404") || currentUrl.contains("/500")) {
            return true;
        }
        return isElementVisible("error-state") || isElementVisible("system-error") || isElementVisible("exception-stack");
    }

    public boolean isLanguagePage() {
        String currentUrl = getCurrentUrl();
        if (currentUrl.contains("/language")) return true;
        return isElementVisible("lang-english") || isElementVisible("lang-french") || isElementVisible(langPageLabel) || isElementVisible("continue");
    }

    public boolean isLoginPage() {
        String currentUrl = getCurrentUrl();
        if (currentUrl.contains("/login")) return true;
        return isElementVisible(loginPageLabel) || isElementVisible(emailLabel);
    }

    public boolean isTargetPageReached(String targetRoute) {
        String currentUrl = getCurrentUrl();
        if (targetRoute == null || targetRoute.isEmpty()) return true;
        String cleanRoute = targetRoute.split("\\?")[0];
        if (cleanRoute.startsWith("http")) {
            cleanRoute = cleanRoute.substring(cleanRoute.indexOf("/", 8));
        }
        return currentUrl.contains(cleanRoute);
    }

    public boolean isLoggedIn() {
        return isElementVisible(logoutLabel);
    }

    public void handleLanguageFlow() {
        try {
            WebElement engBtn = findElementByAriaLabel("lang-english");
            if (engBtn == null) engBtn = findElementByAriaLabel("english");
            if (engBtn != null) {
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", engBtn);
            }
            
            WebElement contBtn = findElementByAriaLabel(langPageLabel);
            if (contBtn == null) contBtn = findElementByAriaLabel("continue");
            if (contBtn != null) {
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", contBtn);
            }
        } catch (Exception e) {
            System.err.println("Language Flow Exception: " + e.getMessage());
        }
    }

    public void handleLoginFlow(String email, String password) {
        try {
            WebElement emailInput = findElementByAriaLabel(emailLabel);
            if (emailInput != null) {
                emailInput.clear();
                emailInput.sendKeys(email);
            }

            WebElement passInput = findElementByAriaLabel(passwordLabel);
            if (passInput != null) {
                passInput.clear();
                passInput.sendKeys(password);
            }

            WebElement submitBtn = findElementByAriaLabel(submitLabel);
            if (submitBtn != null) {
                ((JavascriptExecutor) driver).executeScript("arguments[0].click();", submitBtn);
            }
        } catch (Exception e) {
            System.err.println("Login Flow Exception: " + e.getMessage());
        }
    }

    public void recordSystemError() {
        try {
            String errorUrl = getCurrentUrl();
            System.err.println("[RECORD SYSTEM ERROR] URL: " + errorUrl);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String text = (String) js.executeScript("return document.body ? document.body.innerText : '';");
            if (text != null && text.length() > 0) {
                System.err.println("[RECORD SYSTEM ERROR] Error Snippet: " + text.substring(0, Math.min(250, text.length())));
            }
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
