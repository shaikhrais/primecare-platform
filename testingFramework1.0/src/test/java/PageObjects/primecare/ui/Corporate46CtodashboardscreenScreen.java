package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate46CtodashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 46;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_dashboard-content')]")
	private WebElement primaryContent;

    public Corporate46CtodashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate46CtodashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate46CtodashboardscreenScreen", "/offices/corporate/roles/cto/dashboard");
    }
}

