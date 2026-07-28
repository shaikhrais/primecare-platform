package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth200CompliancemanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 200;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagercompliance-btn-2')]")
	private WebElement compliancemanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagercompliance-btn-1')]")
	private WebElement compliancemanagercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagercompliance-btn-3')]")
	private WebElement compliancemanagercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagercompliance-title')]")
	private WebElement compliancemanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagercompliance-content')]")
	private WebElement compliancemanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagercompliance-screen')]")
	private WebElement compliancemanagercomplianceScreen;

    public Auth200CompliancemanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth200CompliancemanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth200CompliancemanagercompliancescreenScreen", "/management/compliance-manager-compliance");
    }
}

