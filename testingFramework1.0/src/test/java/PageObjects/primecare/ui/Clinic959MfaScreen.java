package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic959MfaScreen extends baseTest {
 
    public static final int SCREEN_ID = 959;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mfa-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mfa-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mfa-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'mfa_view_elevatedbutton_button_1')]")
	private WebElement mfaViewElevatedbuttonButton1;

    public Clinic959MfaScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic959MfaScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic959MfaScreen", "/generated/mfa");
    }
}

