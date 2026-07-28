package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic715CeodashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 715;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic715CeodashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic715CeodashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic715CeodashboardscreenScreen", "/offices/corporate/roles/ceo/dashboard");
    }
}

