package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth221OperationsmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 221;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagercompliance-btn-1')]")
	private WebElement operationsmanagercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagercompliance-title')]")
	private WebElement operationsmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagercompliance-content')]")
	private WebElement operationsmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagercompliance-btn-3')]")
	private WebElement operationsmanagercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagercompliance-btn-2')]")
	private WebElement operationsmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagercompliance-screen')]")
	private WebElement operationsmanagercomplianceScreen;

    public Auth221OperationsmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth221OperationsmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth221OperationsmanagercompliancescreenScreen", "/management/operations-manager-compliance");
    }
}

