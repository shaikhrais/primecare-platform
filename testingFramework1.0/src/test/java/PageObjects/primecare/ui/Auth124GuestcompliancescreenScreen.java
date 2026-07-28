package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth124GuestcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 124;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-loading')]")
	private WebElement guestcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-btn-3')]")
	private WebElement guestcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-screen')]")
	private WebElement guestcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-title')]")
	private WebElement guestcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-btn-4')]")
	private WebElement guestcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-btn-2')]")
	private WebElement guestcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-btn-5')]")
	private WebElement guestcomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-content')]")
	private WebElement guestcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestcompliance-btn-1')]")
	private WebElement guestcomplianceBtn1;

    public Auth124GuestcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth124GuestcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth124GuestcompliancescreenScreen", "/common/guest-compliance");
    }
}

