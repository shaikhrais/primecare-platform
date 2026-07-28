package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic917ConsentmanagementconsolescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 917;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent_management_console-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent_management_console-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent_management_console-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent_management_console_outlinedbutton_button_1')]")
	private WebElement consentManagementConsoleOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent_management_console_iconbutton_button_1')]")
	private WebElement consentManagementConsoleIconbuttonButton1;

    public Clinic917ConsentmanagementconsolescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic917ConsentmanagementconsolescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic917ConsentmanagementconsolescreenScreen", "/generated/consent-management-console");
    }
}

