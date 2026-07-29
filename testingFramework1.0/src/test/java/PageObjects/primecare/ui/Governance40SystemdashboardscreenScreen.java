package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance40SystemdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 40;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_dashboard-content')]")
	private WebElement primaryContent;

    public Governance40SystemdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance40SystemdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance40SystemdashboardscreenScreen", "/common/system-dashboard");
    }
}

