package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth155SystemcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 155;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-btn-3')]")
	private WebElement systemcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-loading')]")
	private WebElement systemcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-btn-1')]")
	private WebElement systemcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-title')]")
	private WebElement systemcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-content')]")
	private WebElement systemcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-btn-2')]")
	private WebElement systemcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemcompliance-screen')]")
	private WebElement systemcomplianceScreen;

    public Auth155SystemcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth155SystemcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth155SystemcompliancescreenScreen", "/common/system-compliance");
    }
}

