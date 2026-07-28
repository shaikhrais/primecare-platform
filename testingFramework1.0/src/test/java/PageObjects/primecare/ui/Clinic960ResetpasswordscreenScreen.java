package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic960ResetpasswordscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 960;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'reset_password-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'reset_password-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'reset_password-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'reset_password_view_elevatedbutton_button_1')]")
	private WebElement resetPasswordViewElevatedbuttonButton1;

    public Clinic960ResetpasswordscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic960ResetpasswordscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic960ResetpasswordscreenScreen", "/generated/reset-password");
    }
}

