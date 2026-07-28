package PageObjectsPrimeCare.ui;

import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;

public class Auth2LoginScreen extends baseTest {

    public static final int SCREEN_ID = 2;

    @FindBy(xpath = "//*[starts-with(@aria-label, 'login-email')]")
    private WebElement emailInput;

    @FindBy(xpath = "//*[starts-with(@aria-label, 'login-password')]")
    private WebElement passwordInput;

    @FindBy(xpath = "//*[@aria-label='login-submit']/following-sibling::flt-semantics[@role='button'] | //flt-semantics[@role='button' and (contains(., 'LOGIN') or contains(., 'Login'))]")
    private WebElement loginButton;

    @FindBy(xpath = "//*[starts-with(@aria-label, 'topbar-logout-button')]/following-sibling::flt-semantics[@role='button'] | //flt-semantics[@role='button' and (contains(., 'Sign Out') or contains(., 'LOGOUT'))]")
    private WebElement signOutButton;

    public Auth2LoginScreen() {
        PageFactory.initElements(driver, this);
    }

    public Auth2LoginScreen(WebDriver driver) {
        PageFactory.initElements(driver, this);
    }

    public boolean isLoaded() {
        return verifyNavigationProtocol(2, "Auth2LoginScreen", "/login");
    }

    public boolean isLoggedIn() {
        try {
            WebElement btn = findSemanticElement("topbar-logout-button");
            if (btn != null) return true;
            if (signOutButton != null) return signOutButton.isDisplayed();
        } catch (Exception e) {
            return false;
        }
        return false;
    }

    public void logout() {
        try {
            if (isLoggedIn()) {
                WebElement btn = findSemanticElement("topbar-logout-button");
                if (btn != null) {
                    ((JavascriptExecutor) driver).executeScript("arguments[0].click();", btn);
                } else if (signOutButton != null) {
                    action.JSClick(driver, signOutButton);
                }
                Thread.sleep(1000);
            }
        } catch (Exception e) {
            System.out.println("Logout failed or not needed: " + e.getMessage());
        }
    }

    public void Login(String email, String password) {
        try {
            logout();

            // Locate elements using robust Shadow DOM / Semantics fallback
            WebElement emailEl = findSemanticElement("login-email");
            if (emailEl == null) emailEl = emailInput;

            WebElement passEl = findSemanticElement("login-password");
            if (passEl == null) passEl = passwordInput;

            WebElement submitEl = findSemanticElement("login-submit");
            if (submitEl == null) submitEl = loginButton;

            if (emailEl != null) {
                action.type(emailEl, email);
            } else {
                setInputValueJS("login-email", email);
            }

            if (passEl != null) {
                action.type(passEl, password);
            } else {
                setInputValueJS("login-password", password);
            }

            if (submitEl != null) {
                try {
                    submitEl.click();
                } catch (Exception e) {
                    ((JavascriptExecutor) driver).executeScript("arguments[0].click();", submitEl);
                }
                System.out.println("Click Action is performed");
            } else {
                clickElementJS("login-submit");
            }

            Thread.sleep(2000);
        } catch (Exception e) {
            System.out.println("Login failed: " + e.getMessage());
        }
    }

    private WebElement findSemanticElement(String targetVal) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            return (WebElement) js.executeScript(
                "var findEl = function(root, val) { " +
                "    if (!root) return null; " +
                "    var selectors = ['[aria-label=\"' + val + '\"]', '[aria-label*=\"' + val + '\"]', '[data-cy=\"' + val + '\"]', '[id=\"' + val + '\"]', '[name=\"' + val + '\"]']; " +
                "    for (var i=0; i<selectors.length; i++) { " +
                "        try { var el = root.querySelector(selectors[i]); if (el) return el; } catch(e){} " +
                "    } " +
                "    var all = root.querySelectorAll('*'); " +
                "    for (var j=0; j<all.length; j++) { " +
                "        var child = all[j]; " +
                "        if (child.tagName.toLowerCase() === 'flt-semantics' || child.tagName.toLowerCase() === 'button' || child.tagName.toLowerCase() === 'input') { " +
                "            var txt = (child.textContent || '').toLowerCase(); " +
                "            if (txt.includes(val.toLowerCase())) return child; " +
                "        } " +
                "        if (child.shadowRoot) { " +
                "            var found = findEl(child.shadowRoot, val); " +
                "            if (found) return found; " +
                "        } " +
                "    } " +
                "    return null; " +
                "}; " +
                "return findEl(document, arguments[0]);",
                targetVal
            );
        } catch (Exception e) {
            return null;
        }
    }

    private void setInputValueJS(String targetVal, String value) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript(
                "var el = document.querySelector('[aria-label*=\"' + arguments[0] + '\"]') || document.querySelector('[data-cy*=\"' + arguments[0] + '\"]'); " +
                "if (el) { " +
                "  el.value = arguments[1]; " +
                "  el.dispatchEvent(new Event('input', { bubbles: true })); " +
                "  el.dispatchEvent(new Event('change', { bubbles: true })); " +
                "}",
                targetVal, value
            );
            System.out.println("Successfully entered value via JS");
        } catch (Exception ignored) {}
    }

    private void clickElementJS(String targetVal) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript(
                "var el = document.querySelector('[aria-label*=\"' + arguments[0] + '\"]') || document.querySelector('[data-cy*=\"' + arguments[0] + '\"]'); " +
                "if (el) el.click();",
                targetVal
            );
            System.out.println("Click Action is performed via JS");
        } catch (Exception ignored) {}
    }
}
