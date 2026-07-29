package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance594ScreenauditscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 594;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit-content')]")
	private WebElement primaryContent;
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

    public Governance594ScreenauditscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance594ScreenauditscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance594ScreenauditscreenScreen", "/common/audit");
    }
}

