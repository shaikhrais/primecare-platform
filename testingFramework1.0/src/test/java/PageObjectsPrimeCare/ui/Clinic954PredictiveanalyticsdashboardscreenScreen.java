package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic954PredictiveanalyticsdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 954;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'predictive_analytics_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'predictive_analytics_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'predictive_analytics_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'predictive_analytics_dashboard_iconbutton_button_1')]")
	private WebElement predictiveAnalyticsDashboardIconbuttonButton1;

    public Clinic954PredictiveanalyticsdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic954PredictiveanalyticsdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic954PredictiveanalyticsdashboardscreenScreen", "/generated/predictive-analytics-dashboard");
    }
}
