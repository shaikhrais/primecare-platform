package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth255RpncompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 255;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-btn-3')]")
	private WebElement rpncomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-title')]")
	private WebElement rpncomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-loading')]")
	private WebElement rpncomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-btn-2')]")
	private WebElement rpncomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-btn-1')]")
	private WebElement rpncomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-screen')]")
	private WebElement rpncomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpncompliance-content')]")
	private WebElement rpncomplianceContent;

    public Auth255RpncompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth255RpncompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth255RpncompliancescreenScreen", "/offices/clinical/roles/rpn/rpn-compliance");
    }
}

