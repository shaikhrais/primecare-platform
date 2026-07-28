package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth3SuccessScreen extends baseTest {
 
    public static final int SCREEN_ID = 3;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'topbar-logout-button')]/following-sibling::flt-semantics[@role='button'] | //flt-semantics[@role='button' and (contains(., 'Sign Out') or contains(., 'LOGOUT'))]")
    public WebElement logoutButton;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'topbar-user-menu')]")
    public WebElement userMenu;
 
    public Auth3SuccessScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth3SuccessScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth3SuccessScreen", "/success");
    }
}

