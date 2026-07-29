package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Marketing509CampaigndashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 509;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaign_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-content')]")
	private WebElement campaigndashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-btn-1')]")
	private WebElement campaigndashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-title')]")
	private WebElement campaigndashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-loading')]")
	private WebElement campaigndashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-btn-2')]")
	private WebElement campaigndashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-btn-3')]")
	private WebElement campaigndashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'campaigndashboard-screen')]")
	private WebElement campaigndashboardScreen;

    public Marketing509CampaigndashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Marketing509CampaigndashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Marketing509CampaigndashboardscreenScreen", "/management/campaign-dashboard");
    }
}

