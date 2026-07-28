package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic849SecuritysentinelscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 849;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_sentinel-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_sentinel-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_sentinel-content')]")
	private WebElement primaryContent;

    public Clinic849SecuritysentinelscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic849SecuritysentinelscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic849SecuritysentinelscreenScreen", "/governance/security");
    }
}

