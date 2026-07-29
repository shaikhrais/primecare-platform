package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth188OwnercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 188;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-title')]")
	private WebElement ownercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-loading')]")
	private WebElement ownercomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-btn-2')]")
	private WebElement ownercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-content')]")
	private WebElement ownercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-btn-1')]")
	private WebElement ownercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-btn-3')]")
	private WebElement ownercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownercompliance-screen')]")
	private WebElement ownercomplianceScreen;

    public Auth188OwnercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth188OwnercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth188OwnercompliancescreenScreen", "/executive/owner-compliance");
    }
}

