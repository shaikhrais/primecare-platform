package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic923HipaaauditdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 923;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hipaa_audit_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hipaa_audit_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hipaa_audit_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hipaa_audit_dashboard_iconbutton_button_1')]")
	private WebElement hipaaAuditDashboardIconbuttonButton1;

    public Clinic923HipaaauditdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic923HipaaauditdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic923HipaaauditdashboardscreenScreen", "/generated/hipaa-audit-dashboard");
    }
}

