package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth268HrmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 268;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-btn-4')]")
	private WebElement hrmanagercomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-btn-3')]")
	private WebElement hrmanagercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-btn-5')]")
	private WebElement hrmanagercomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-btn-1')]")
	private WebElement hrmanagercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-title')]")
	private WebElement hrmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-content')]")
	private WebElement hrmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-btn-2')]")
	private WebElement hrmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagercompliance-screen')]")
	private WebElement hrmanagercomplianceScreen;

    public Auth268HrmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth268HrmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth268HrmanagercompliancescreenScreen", "/staff/hr-manager-compliance");
    }
}

