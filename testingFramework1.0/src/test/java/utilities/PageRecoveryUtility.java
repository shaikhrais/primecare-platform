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
import primecare.testing.framework.database.Repositories.ScreenRepository;
import primecare.testing.framework.planning.Models.ScreenDefinition;

public class PageRecoveryUtility {

    private static final int MAX_ATTEMPTS = 3;

    private final WebDriver driver;
    private final WebDriverWait wait;
    private final String loginUrl;

    private final String langPageLabel = "language-continue-button";
    private final String loginPageLabel = "login-email";
    private final String emailLabel = "login-email";
    private final String passwordLabel = "login-password";
    private final String submitLabel = "login-submit";
    private final String logoutLabel = "topbar-logout-button";

    public PageRecoveryUtility(
        WebDriver driver,
        String loginUrl
    ) {
        this.driver = driver;
        this.loginUrl = loginUrl;

        this.wait = new WebDriverWait(
            driver,
            Duration.ofSeconds(15)
        );
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

    public boolean isOnLanguagePage() {
        String url = driver.getCurrentUrl();
        if (url != null && url.contains("/language")) return true;
        return isElementVisible("lang-english") || isElementVisible("lang-french") || isElementVisible(langPageLabel) || isElementVisible("continue");
    }

    public boolean isOnLoginPage() {
        String url = driver.getCurrentUrl();
        if (url != null && url.contains("/login")) return true;
        return isElementVisible(loginPageLabel) || isElementVisible(emailLabel);
    }

    public boolean isLoggedIn() {
        return isElementVisible(logoutLabel);
    }

    public void handleLanguagePage() {
        System.out.println("[Recovery] Handling Language Selection Page...");
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
            System.err.println("[Recovery] Language page selection warning: " + e.getMessage());
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

                if (isOnLanguagePage()) {
                    System.out.println("[Recovery] Currently on Language page. Selecting language...");
                    handleLanguagePage();
                    Thread.sleep(1000);
                }

                if (isOnLoginPage()) {
                    System.out.println("[Recovery] Successfully recovered to Login page!");
                    return;
                }

                System.out.println("[Recovery] Navigating directly to Login URL: " + loginUrl);
                driver.get(loginUrl);
                Thread.sleep(1000);

                if (isOnLanguagePage()) {
                    handleLanguagePage();
                    Thread.sleep(1000);
                }

                if (isOnLoginPage()) {
                    System.out.println("[Recovery] Successfully reached Login page after direct navigation!");
                    return;
                }
            } catch (Exception e) {
                System.err.println("[Recovery] Attempt " + attempt + " encountered exception: " + e.getMessage());
            }
        }

        Assert.fail("[Recovery] Failed to recover to Login page after " + MAX_ATTEMPTS + " attempts.");
    }
}
