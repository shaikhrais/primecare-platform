package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic833AuditlogscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 833;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_log-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_log-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_log-content')]")
	private WebElement primaryContent;

    public Clinic833AuditlogscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic833AuditlogscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic833AuditlogscreenScreen", "/governance/audit");
    }
}
