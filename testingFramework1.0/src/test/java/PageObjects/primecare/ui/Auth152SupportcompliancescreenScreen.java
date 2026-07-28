package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth152SupportcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 152;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-btn-2')]")
	private WebElement supportcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-content')]")
	private WebElement supportcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-title')]")
	private WebElement supportcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-screen')]")
	private WebElement supportcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-btn-3')]")
	private WebElement supportcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-loading')]")
	private WebElement supportcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportcompliance-btn-1')]")
	private WebElement supportcomplianceBtn1;

    public Auth152SupportcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth152SupportcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth152SupportcompliancescreenScreen", "/common/support-compliance");
    }
}

