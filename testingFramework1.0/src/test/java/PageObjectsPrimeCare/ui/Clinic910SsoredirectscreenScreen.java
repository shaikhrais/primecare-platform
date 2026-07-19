package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic910SsoredirectscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 910;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sso_redirect-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sso_redirect-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sso_redirect-content')]")
	private WebElement primaryContent;

    public Clinic910SsoredirectscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic910SsoredirectscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic910SsoredirectscreenScreen", "/generated/sso-redirect");
    }
}
