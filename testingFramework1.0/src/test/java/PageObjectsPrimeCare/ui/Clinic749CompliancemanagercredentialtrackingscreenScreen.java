package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic749CompliancemanagercredentialtrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 749;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_credential_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_credential_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_credential_tracking-content')]")
	private WebElement primaryContent;

    public Clinic749CompliancemanagercredentialtrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic749CompliancemanagercredentialtrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic749CompliancemanagercredentialtrackingscreenScreen", "/generated/compliance-manager-credential-tracking");
    }
}
