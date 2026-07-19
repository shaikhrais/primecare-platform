package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client586EmergencycontactsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 586;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergency_contacts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergency_contacts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergency_contacts-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-btn-3')]")
	private WebElement emergencycontactsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-screen')]")
	private WebElement emergencycontactsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-title')]")
	private WebElement emergencycontactsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-content')]")
	private WebElement emergencycontactsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-btn-1')]")
	private WebElement emergencycontactsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-btn-2')]")
	private WebElement emergencycontactsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'emergencycontacts-loading')]")
	private WebElement emergencycontactsLoading;

    public Client586EmergencycontactsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client586EmergencycontactsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client586EmergencycontactsscreenScreen", "/common/emergency-contacts");
    }
}
