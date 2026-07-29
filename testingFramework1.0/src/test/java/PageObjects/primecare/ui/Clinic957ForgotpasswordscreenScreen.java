package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic957ForgotpasswordscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 957;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'forgot_password-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'forgot_password-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'forgot_password-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'forgot_password_view_elevatedbutton_button_1')]")
	private WebElement forgotPasswordViewElevatedbuttonButton1;

    public Clinic957ForgotpasswordscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic957ForgotpasswordscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic957ForgotpasswordscreenScreen", "/generated/forgot-password");
    }
}

