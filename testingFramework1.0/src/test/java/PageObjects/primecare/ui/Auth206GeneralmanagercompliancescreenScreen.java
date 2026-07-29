package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth206GeneralmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 206;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-title')]")
	private WebElement generalmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-content')]")
	private WebElement generalmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-btn-5')]")
	private WebElement generalmanagercomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-btn-1')]")
	private WebElement generalmanagercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-btn-3')]")
	private WebElement generalmanagercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-btn-4')]")
	private WebElement generalmanagercomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-btn-2')]")
	private WebElement generalmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagercompliance-screen')]")
	private WebElement generalmanagercomplianceScreen;

    public Auth206GeneralmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth206GeneralmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth206GeneralmanagercompliancescreenScreen", "/management/general-manager-compliance");
    }
}

