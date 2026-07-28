package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth87RmtcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 87;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-content')]")
	private WebElement rmtcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-screen')]")
	private WebElement rmtcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-btn-3')]")
	private WebElement rmtcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-loading')]")
	private WebElement rmtcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-btn-1')]")
	private WebElement rmtcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-btn-2')]")
	private WebElement rmtcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtcompliance-title')]")
	private WebElement rmtcomplianceTitle;

    public Auth87RmtcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth87RmtcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth87RmtcompliancescreenScreen", "/offices/clinical/roles/rmt/compliance");
    }
}

