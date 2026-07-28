package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client495CompliancedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 495;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancedashboard-title')]")
	private WebElement compliancedashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancedashboard-btn-3')]")
	private WebElement compliancedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancedashboard-btn-1')]")
	private WebElement compliancedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancedashboard-btn-2')]")
	private WebElement compliancedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancedashboard-screen')]")
	private WebElement compliancedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancedashboard-content')]")
	private WebElement compliancedashboardContent;

    public Client495CompliancedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client495CompliancedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client495CompliancedashboardscreenScreen", "/management/compliance-dashboard");
    }
}

