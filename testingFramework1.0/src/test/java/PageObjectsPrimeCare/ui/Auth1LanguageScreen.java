package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth1LanguageScreen extends baseTest {
 
    public static final int SCREEN_ID = 1;
 
    @FindBy(xpath = "//flt-semantics[@role='button' and contains(., 'lang-english')]")
    public WebElement langEnglishButton;
 
    @FindBy(xpath = "//flt-semantics[@role='button' and contains(., 'lang-french')]")
    public WebElement langFrenchButton;
 
    @FindBy(xpath = "//flt-semantics[@role='button' and contains(., 'CONTINUE')]")
    public WebElement continueButton;
 
    public Auth1LanguageScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth1LanguageScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public void selectLanguage(String lang) {
        try {
            if ("en".equalsIgnoreCase(lang)) {
                action.explicitWait(driver, langEnglishButton, 10);
                action.JSClick(driver, langEnglishButton);
            } else {
                action.explicitWait(driver, langFrenchButton, 10);
                action.JSClick(driver, langFrenchButton);
            }
        } catch (org.openqa.selenium.StaleElementReferenceException ignored) {}
    }
 
    public void clickContinue() {
        try {
            if (driver.getCurrentUrl().contains("/language")) {
                action.explicitWait(driver, continueButton, 5);
                action.JSClick(driver, continueButton);
            }
        } catch (Exception ignored) {}
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(1, "Auth1LanguageScreen", "/language");
    }
}
