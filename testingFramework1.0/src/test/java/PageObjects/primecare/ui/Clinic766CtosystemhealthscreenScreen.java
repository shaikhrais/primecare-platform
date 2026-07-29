package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic766CtosystemhealthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 766;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_system_health-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_system_health-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_system_health-content')]")
	private WebElement primaryContent;

    public Clinic766CtosystemhealthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic766CtosystemhealthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic766CtosystemhealthscreenScreen", "/offices/corporate/roles/cto/system-health");
    }
}

