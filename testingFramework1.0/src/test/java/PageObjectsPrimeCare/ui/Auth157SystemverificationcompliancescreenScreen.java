package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth157SystemverificationcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 157;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationcompliance-screen')]")
	private WebElement systemverificationcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationcompliance-btn-3')]")
	private WebElement systemverificationcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationcompliance-btn-1')]")
	private WebElement systemverificationcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationcompliance-content')]")
	private WebElement systemverificationcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationcompliance-title')]")
	private WebElement systemverificationcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationcompliance-btn-2')]")
	private WebElement systemverificationcomplianceBtn2;

    public Auth157SystemverificationcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth157SystemverificationcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth157SystemverificationcompliancescreenScreen", "/common/system-verification-compliance");
    }
}
