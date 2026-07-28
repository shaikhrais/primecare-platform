package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic869LocalmarketingmanagereventsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 869;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_events-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_events-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_events-content')]")
	private WebElement primaryContent;

    public Clinic869LocalmarketingmanagereventsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic869LocalmarketingmanagereventsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic869LocalmarketingmanagereventsscreenScreen", "/generated/local-marketing-manager-events");
    }
}

