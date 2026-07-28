package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1038ScreenauditscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1038;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_audit-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_audit-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_audit-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit-content')]")
	private WebElement auditContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gov-dashboard-generate-audit-report')]")
	private WebElement govDashboardGenerateAuditReport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gov-dashboard-send-compliance-alert')]")
	private WebElement govDashboardSendComplianceAlert;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gov-dashboard-refresh-data')]")
	private WebElement govDashboardRefreshData;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gov-dashboard-update-governance-document')]")
	private WebElement govDashboardUpdateGovernanceDocument;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gov-dashboard-view-training-resources')]")
	private WebElement govDashboardViewTrainingResources;

    public Clinic1038ScreenauditscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1038ScreenauditscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1038ScreenauditscreenScreen", "/generated/screen-audit");
    }
}

