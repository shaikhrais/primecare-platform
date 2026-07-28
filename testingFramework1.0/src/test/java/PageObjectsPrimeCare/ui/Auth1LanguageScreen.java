package PageObjectsPrimeCare.ui;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;
import base.baseTest;

public class Auth1LanguageScreen extends baseTest {

    public static final int SCREEN_ID = 1;

    @FindBy(xpath = "//flt-semantics[@role='button' and (contains(., 'lang-english') or contains(., 'English'))]")
    public WebElement langEnglishButton;

    @FindBy(xpath = "//flt-semantics[@role='button' and (contains(., 'lang-french') or contains(., 'French'))]")
    public WebElement langFrenchButton;

    @FindBy(xpath = "//flt-semantics[@role='button' and (contains(., 'CONTINUE') or contains(., 'Continue'))]")
    public WebElement continueButton;

    public Auth1LanguageScreen() {
        PageFactory.initElements(driver, this);
    }

    public Auth1LanguageScreen(WebDriver driver) {
        PageFactory.initElements(driver, this);
    }

    public void selectLanguage(String lang) {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        try {
            // Find semantic button by aria-label, data-cy, or flt-semantics text
            WebElement btn = findLanguageElement(lang);
            if (btn != null) {
                try {
                    btn.click();
                } catch (Exception e) {
                    ((JavascriptExecutor) driver).executeScript("arguments[0].click();", btn);
                }
            } else {
                if ("en".equalsIgnoreCase(lang) && langEnglishButton != null) {
                    action.explicitWait(driver, langEnglishButton, 5);
                    action.JSClick(driver, langEnglishButton);
                } else if (langFrenchButton != null) {
                    action.explicitWait(driver, langFrenchButton, 5);
                    action.JSClick(driver, langFrenchButton);
                }
            }
        } catch (Exception e) {
            System.out.println("[LanguageScreen] Retrying language selection (" + lang + "): " + e.getMessage());
        }
    }

    public void clickContinue() {
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
        try {
            WebElement btn = findContinueElement();
            if (btn != null) {
                try {
                    btn.click();
                } catch (Exception e) {
                    ((JavascriptExecutor) driver).executeScript("arguments[0].click();", btn);
                }
            } else if (continueButton != null) {
                action.JSClick(driver, continueButton);
            }
        } catch (Exception e) {
            System.out.println("[LanguageScreen] Retrying continue button click: " + e.getMessage());
        }
    }

    private WebElement findLanguageElement(String lang) {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            String searchTarget = "en".equalsIgnoreCase(lang) ? "english" : "french";
            return (WebElement) js.executeScript(
                "var val = arguments[0]; " +
                "var selectors = ['[aria-label*=\"' + val + '\"]', '[data-cy*=\"' + val + '\"]', '[id*=\"' + val + '\"]']; " +
                "for (var i=0; i<selectors.length; i++) { " +
                "  var el = document.querySelector(selectors[i]); " +
                "  if (el) return el; " +
                "} " +
                "var elems = document.querySelectorAll('flt-semantics, button, div'); " +
                "for (var j=0; j<elems.length; j++) { " +
                "  var txt = (elems[j].textContent || '').toLowerCase(); " +
                "  if (txt.includes(val)) return elems[j]; " +
                "} " +
                "return null;",
                searchTarget
            );
        } catch (Exception e) {
            return null;
        }
    }

    private WebElement findContinueElement() {
        try {
            JavascriptExecutor js = (JavascriptExecutor) driver;
            return (WebElement) js.executeScript(
                "var selectors = ['[aria-label*=\"continue\"]', '[data-cy*=\"continue\"]', '[id*=\"continue\"]']; " +
                "for (var i=0; i<selectors.length; i++) { " +
                "  var el = document.querySelector(selectors[i]); " +
                "  if (el) return el; " +
                "} " +
                "var elems = document.querySelectorAll('flt-semantics, button, div'); " +
                "for (var j=0; j<elems.length; j++) { " +
                "  var txt = (elems[j].textContent || '').toLowerCase(); " +
                "  if (txt.includes('continue')) return elems[j]; " +
                "} " +
                "return null;"
            );
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isLoaded() {
        return verifyNavigationProtocol(1, "Auth1LanguageScreen", "/language");
    }
}
