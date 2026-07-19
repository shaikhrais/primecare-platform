package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic931ProviderperformancedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 931;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'provider_performance_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'provider_performance_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'provider_performance_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'provider_performance_dashboard_iconbutton_button_1')]")
	private WebElement providerPerformanceDashboardIconbuttonButton1;

    public Clinic931ProviderperformancedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic931ProviderperformancedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic931ProviderperformancedashboardscreenScreen", "/generated/provider-performance-dashboard");
    }
}
