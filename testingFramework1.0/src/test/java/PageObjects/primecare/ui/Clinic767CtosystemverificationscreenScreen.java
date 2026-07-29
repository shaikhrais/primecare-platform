package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic767CtosystemverificationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 767;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_system_verification-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_system_verification-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_system_verification-content')]")
	private WebElement primaryContent;

    public Clinic767CtosystemverificationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic767CtosystemverificationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic767CtosystemverificationscreenScreen", "/offices/corporate/roles/cto/system-verification");
    }
}

