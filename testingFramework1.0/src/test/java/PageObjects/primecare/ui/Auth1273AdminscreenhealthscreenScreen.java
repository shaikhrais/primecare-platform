package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth1273AdminscreenhealthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1273;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_screen_health-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_screen_health-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_screen_health-content')]")
	private WebElement primaryContent;

    public Auth1273AdminscreenhealthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth1273AdminscreenhealthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth1273AdminscreenhealthscreenScreen", "/admin/screen-health");
    }
}

