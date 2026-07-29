package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic768CtoverificationhubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 768;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_verification_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_verification_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_verification_hub-content')]")
	private WebElement primaryContent;

    public Clinic768CtoverificationhubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic768CtoverificationhubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic768CtoverificationhubscreenScreen", "/offices/corporate/roles/cto/verification-hub");
    }
}

