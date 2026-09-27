package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate45CoodashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 45;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_dashboard-content')]")
	private WebElement primaryContent;

    public Corporate45CoodashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate45CoodashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate45CoodashboardscreenScreen", "/offices/corporate/roles/coo/dashboard");
    }
}

