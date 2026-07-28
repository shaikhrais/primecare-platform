package utilities;

import java.time.Duration;
import java.util.List;
import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

public class PageRecoveryUtility {

    private static final int MAX_ATTEMPTS = 3;

    public enum PageState {
        LANGUAGE_PAGE,
        LOGIN_PAGE,
        SYSTEM_ERROR,
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
     * STEP 1: Identify current state by inspecting actual URL and DOM elements.
     */
    public PageState identifyPageState() {
        String currentUrl = "";
        try {
            currentUrl = driver.getCurrentUrl();
        } catch (Exception e) {
            currentUrl = "";
        }

        System.out.println("[PageRecovery] Identifying current page state. Actual URL: " + currentUrl);

        // Check System Error State first
        if (isSystemErrorState(currentUrl)) {
            System.out.println("[PageRecovery] Detected State: SYSTEM_ERROR");
            return PageState.SYSTEM_ERROR;
        }

        // Check Language Page State
        if (isLanguagePageState(currentUrl)) {
            System.out.println("[PageRecovery] Detected State: LANGUAGE_PAGE");
            return PageState.LANGUAGE_PAGE;
        }

        // Check Login Page State
        if (isLoginPageState(currentUrl)) {
            System.out.println("[PageRecovery] Detected State: LOGIN_PAGE");
            return PageState.LOGIN_PAGE;
        }

        // Check Authenticated Dashboard State
        if (isLoggedIn()) {
            System.out.println("[PageRecovery] Detected State: AUTHENTICATED_DASHBOARD");
            return PageState.AUTHENTICATED_DASHBOARD;
        }

        return PageState.UNKNOWN;
    }

    /**
     * STEP 2: Execute target flow based on identified page state.
     */
    public void executeStateFlow(String email, String password) {
        PageState state = identifyPageState();

        switch (state) {
            case LANGUAGE_PAGE:
                System.out.println("[Flow] Executing Language Flow...");
                handleLanguageFlow();
                break;

            case LOGIN_PAGE:
                System.out.println("[Flow] Executing Login Flow...");
                handleLoginFlow(email, password);
                break;

            case SYSTEM_ERROR:
                System.out.println("[Flow] Recording System Error & Recovering...");
                recordSystemError();
                recoverToLoginPage();
                break;

            case AUTHENTICATED_DASHBOARD:
                System.out.println("[Flow] Already authenticated. Proceeding to target workspace...");
                break;

            default:
                System.out.println("[Flow] Unknown state. Navigating to login URL: " + loginUrl);
                driver.get(loginUrl);
                break;
        }
    }

    public boolean isLanguagePageState(String currentUrl) {
        if (currentUrl != null && currentUrl.contains("/language")) return true;
        return isElementVisible("lang-english") || isElementVisible("lang-french") || isElementVisible(langPageLabel) || isElementVisible("continue");
    }

    public boolean isLoginPageState(String currentUrl) {
        if (currentUrl != null && currentUrl.contains("/login")) return true;
        return isElementVisible(loginPageLabel) || isElementVisible(emailLabel);
    }

    public boolean isSystemErrorState(String currentUrl) {
        if (currentUrl != null && (currentUrl.contains("/error") || currentUrl.contains("/404") || currentUrl.contains("/500"))) {
            return true;
        }
        return isElementVisible("error-state") || isElementVisible("system-error") || isElementVisible("exception-stack");
    }

    public boolean isLoggedIn() {
        return isElementVisible(logoutLabel);
    }

    /**
     * LANGUAGE FLOW: Select English/French language and click Continue
     */
    public void handleLanguageFlow() {
        System.out.println("[Language Flow] Selecting default language (English) and clicking Continue...");
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
            System.out.println("[Language Flow] Language selection completed successfully!");
        } catch (Exception e) {
            System.err.println("[Language Flow] Warning: " + e.getMessage());
        }
    }

    /**
     * LOGIN FLOW: Fill credentials and submit
     */
    public void handleLoginFlow(String email, String password) {
        System.out.println("[Login Flow] Filling credentials for: " + email);
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
            System.out.println("[Login Flow] Submitted login credentials.");
        } catch (Exception e) {
            System.err.println("[Login Flow] Warning: " + e.getMessage());
        }
    }

    /**
     * RECORD SYSTEM ERROR: Capture stack trace, URL, and log error details
     */
    public void recordSystemError() {
        try {
            String errorUrl = driver.getCurrentUrl();
            System.err.println("[ERROR RECORD] System Error Detected at URL: " + errorUrl);
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String pageText = (String) js.executeScript("return document.body ? document.body.innerText : '';");
            System.err.println("[ERROR RECORD] Page Contents Preview: " + (pageText != null ? pageText.substring(0, Math.min(200, pageText.length())) : "EMPTY"));
        } catch (Exception e) {
            System.err.println("[ERROR RECORD] Failed to record error: " + e.getMessage());
        }
    }

    public void recoverToLoginPage() {
        for (int attempt = 1; attempt <= MAX_ATTEMPTS; attempt++) {
            System.out.println("[Recovery] Recovery attempt " + attempt + " of " + MAX_ATTEMPTS);
            try {
                if (isLoggedIn()) {
                    System.out.println("[Recovery] User is logged in. Clicking logout...");
                    WebElement logout = findElementByAriaLabel(logoutLabel);
                    if (logout != null) {
                        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", logout);
                        Thread.sleep(1000);
                    }
                }

                PageState state = identifyPageState();
                if (state == PageState.LANGUAGE_PAGE) {
                    handleLanguageFlow();
                    Thread.sleep(1000);
                }

                if (state == PageState.LOGIN_PAGE) {
                    System.out.println("[Recovery] Reached Login page successfully!");
                    return;
                }

                System.out.println("[Recovery] Directing to Login URL: " + loginUrl);
                driver.get(loginUrl);
                Thread.sleep(1000);

                if (identifyPageState() == PageState.LOGIN_PAGE) {
                    System.out.println("[Recovery] Successfully arrived on Login page!");
                    return;
                }
            } catch (Exception e) {
                System.err.println("[Recovery] Attempt " + attempt + " exception: " + e.getMessage());
            }
        }
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
}
