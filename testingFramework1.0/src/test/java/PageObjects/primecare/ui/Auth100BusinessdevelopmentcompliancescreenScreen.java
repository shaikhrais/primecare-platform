package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth100BusinessdevelopmentcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 100;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentcompliance-title')]")
	private WebElement businessdevelopmentcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentcompliance-content')]")
	private WebElement businessdevelopmentcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentcompliance-btn-1')]")
	private WebElement businessdevelopmentcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentcompliance-screen')]")
	private WebElement businessdevelopmentcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentcompliance-btn-3')]")
	private WebElement businessdevelopmentcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentcompliance-btn-2')]")
	private WebElement businessdevelopmentcomplianceBtn2;

    public Auth100BusinessdevelopmentcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth100BusinessdevelopmentcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth100BusinessdevelopmentcompliancescreenScreen", "/common/business-development-compliance");
    }
}

