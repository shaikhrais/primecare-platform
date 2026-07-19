package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth218LocalmarketingmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 218;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagercompliance-title')]")
	private WebElement localmarketingmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagercompliance-screen')]")
	private WebElement localmarketingmanagercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagercompliance-content')]")
	private WebElement localmarketingmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagercompliance-btn-2')]")
	private WebElement localmarketingmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagercompliance-btn-1')]")
	private WebElement localmarketingmanagercomplianceBtn1;

    public Auth218LocalmarketingmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth218LocalmarketingmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth218LocalmarketingmanagercompliancescreenScreen", "/management/local-marketing-manager-compliance");
    }
}
