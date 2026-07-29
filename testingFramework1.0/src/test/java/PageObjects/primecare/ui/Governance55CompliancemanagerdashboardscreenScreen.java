package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance55CompliancemanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 55;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerdashboard-screen')]")
	private WebElement compliancemanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerdashboard-title')]")
	private WebElement compliancemanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerdashboard-btn-1')]")
	private WebElement compliancemanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerdashboard-btn-2')]")
	private WebElement compliancemanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerdashboard-btn-3')]")
	private WebElement compliancemanagerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerdashboard-content')]")
	private WebElement compliancemanagerdashboardContent;

    public Governance55CompliancemanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance55CompliancemanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance55CompliancemanagerdashboardscreenScreen", "/offices/corporate/roles/compliance_manager/dashboard");
    }
}

