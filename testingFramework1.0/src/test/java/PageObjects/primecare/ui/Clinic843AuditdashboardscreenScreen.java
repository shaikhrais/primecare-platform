package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic843AuditdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 843;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic843AuditdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic843AuditdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic843AuditdashboardscreenScreen", "/generated/audit-dashboard");
    }
}

