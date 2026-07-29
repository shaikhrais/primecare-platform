package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic983CampaignperformancedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 983;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_performance_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_performance_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_performance_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_performance_dashboard_iconbutton_button_1')]")
	private WebElement campaignPerformanceDashboardIconbuttonButton1;

    public Clinic983CampaignperformancedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic983CampaignperformancedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic983CampaignperformancedashboardscreenScreen", "/generated/campaign-performance-dashboard");
    }
}

