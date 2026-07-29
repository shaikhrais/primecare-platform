package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth252RncompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 252;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-btn-2')]")
	private WebElement rncomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-content')]")
	private WebElement rncomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-btn-1')]")
	private WebElement rncomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-screen')]")
	private WebElement rncomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-loading')]")
	private WebElement rncomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-btn-3')]")
	private WebElement rncomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncompliance-title')]")
	private WebElement rncomplianceTitle;

    public Auth252RncompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth252RncompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth252RncompliancescreenScreen", "/offices/clinical/roles/rn/rn-compliance");
    }
}

