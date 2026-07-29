package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client26CustomersupportdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 26;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_dashboard-content')]")
	private WebElement primaryContent;

    public Client26CustomersupportdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client26CustomersupportdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client26CustomersupportdashboardscreenScreen", "/common/customer-support-dashboard");
    }
}

