package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic666FamilydashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 666;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic666FamilydashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic666FamilydashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic666FamilydashboardscreenScreen", "/offices/client/roles/family_member/dashboard");
    }
}

