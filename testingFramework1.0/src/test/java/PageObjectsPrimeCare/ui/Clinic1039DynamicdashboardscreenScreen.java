package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1039DynamicdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1039;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dashboard-btn-run-compliance-scan')]")
	private WebElement dashboardBtnRunComplianceScan;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dashboard-btn-trigger-actions')]")
	private WebElement dashboardBtnTriggerActions;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicscreendashboard-content')]")
	private WebElement dynamicscreendashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dashboard-btn-update-policies')]")
	private WebElement dashboardBtnUpdatePolicies;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dashboard-btn-refresh-telemetry')]")
	private WebElement dashboardBtnRefreshTelemetry;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dashboard-btn-export-logs')]")
	private WebElement dashboardBtnExportLogs;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dashboard-btn-sync-security-posture')]")
	private WebElement dashboardBtnSyncSecurityPosture;

    public Clinic1039DynamicdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1039DynamicdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1039DynamicdashboardscreenScreen", "/generated/dynamic-dashboard");
    }
}
