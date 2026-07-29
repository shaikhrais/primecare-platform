package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1014SocialdeterminantsofhealthtrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1014;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_determinants_of_health_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_determinants_of_health_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_determinants_of_health_tracker-content')]")
	private WebElement primaryContent;

    public Clinic1014SocialdeterminantsofhealthtrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1014SocialdeterminantsofhealthtrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1014SocialdeterminantsofhealthtrackerscreenScreen", "/generated/social-determinants-of-health-tracker");
    }
}

