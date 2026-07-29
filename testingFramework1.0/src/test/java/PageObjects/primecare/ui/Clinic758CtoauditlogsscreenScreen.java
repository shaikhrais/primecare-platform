package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic758CtoauditlogsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 758;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_audit_logs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_audit_logs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_audit_logs-content')]")
	private WebElement primaryContent;

    public Clinic758CtoauditlogsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic758CtoauditlogsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic758CtoauditlogsscreenScreen", "/offices/corporate/roles/cto/audit-logs");
    }
}

