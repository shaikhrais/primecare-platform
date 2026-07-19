package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic735CredentialtrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 735;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credential_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credential_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credential_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialtrackingscreen-screen')]")
	private WebElement credentialtrackingscreenScreen;

    public Clinic735CredentialtrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic735CredentialtrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic735CredentialtrackingscreenScreen", "/offices/corporate/roles/compliance_manager/credential-tracking");
    }
}
