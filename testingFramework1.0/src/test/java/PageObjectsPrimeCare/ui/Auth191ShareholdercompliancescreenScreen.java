package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth191ShareholdercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 191;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-btn-4')]")
	private WebElement shareholdercomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-btn-5')]")
	private WebElement shareholdercomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-title')]")
	private WebElement shareholdercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-btn-1')]")
	private WebElement shareholdercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-content')]")
	private WebElement shareholdercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-screen')]")
	private WebElement shareholdercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-btn-3')]")
	private WebElement shareholdercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholdercompliance-btn-2')]")
	private WebElement shareholdercomplianceBtn2;

    public Auth191ShareholdercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth191ShareholdercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth191ShareholdercompliancescreenScreen", "/executive/shareholder-compliance");
    }
}
