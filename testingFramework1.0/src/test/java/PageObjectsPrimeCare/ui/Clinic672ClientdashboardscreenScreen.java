package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic672ClientdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 672;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic672ClientdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic672ClientdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic672ClientdashboardscreenScreen", "/generated/client-dashboard");
    }
}
