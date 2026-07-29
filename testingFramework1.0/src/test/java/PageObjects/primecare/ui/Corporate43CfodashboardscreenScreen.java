package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate43CfodashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 43;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_dashboard-content')]")
	private WebElement primaryContent;

    public Corporate43CfodashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate43CfodashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate43CfodashboardscreenScreen", "/offices/corporate/roles/cfo/dashboard");
    }
}

