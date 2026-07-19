package PageObjectsPrimeCare.ui;
 
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
 
    @FindBy(xpath = "//*[@aria-label='login-submit']/following-sibling::flt-semantics[@role='button'] | //flt-semantics[@role='button' and contains(., 'LOGIN')]")
    private WebElement loginButton;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'topbar-logout-button')]/following-sibling::flt-semantics[@role='button'] | //flt-semantics[@role='button' and (contains(., 'Sign Out') or contains(., 'LOGOUT'))]")
    private WebElement signOutButton;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'login-forgot-password')]")
    private WebElement forgotPasswordLink;
 
    public Auth2LoginScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth2LoginScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(2, "Auth2LoginScreen", "/login");
    }
 
    public boolean isLoggedIn() {
        try {
            action.explicitWait(driver, signOutButton, 5);
            return signOutButton.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
 
    public void logout() {
        try {
            if (isLoggedIn()) {
                action.JSClick(driver, signOutButton);
                Thread.sleep(2000);
            }
        } catch (Exception e) {
            System.out.println("Logout failed or not needed: " + e.getMessage());
        }
    }
 
    public void Login(String email, String password) {
        try {
            logout();
            action.type(emailInput, email);
            action.type(passwordInput, password);
            action.JSClick(driver, loginButton);
            Thread.sleep(3000);
        } catch (Exception e) {
            System.out.println("Login failed: " + e.getMessage());
        }
    }
}
