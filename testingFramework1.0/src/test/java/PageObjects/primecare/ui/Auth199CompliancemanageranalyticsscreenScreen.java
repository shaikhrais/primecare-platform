package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth199CompliancemanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 199;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanageranalytics-btn-2')]")
	private WebElement compliancemanageranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanageranalytics-btn-1')]")
	private WebElement compliancemanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanageranalytics-title')]")
	private WebElement compliancemanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanageranalytics-content')]")
	private WebElement compliancemanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanageranalytics-screen')]")
	private WebElement compliancemanageranalyticsScreen;

    public Auth199CompliancemanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth199CompliancemanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth199CompliancemanageranalyticsscreenScreen", "/management/compliance-manager-analytics");
    }
}

