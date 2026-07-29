package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client54CommunityoutreachdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 54;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachdashboard-title')]")
	private WebElement communityoutreachdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachdashboard-btn-1')]")
	private WebElement communityoutreachdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachdashboard-content')]")
	private WebElement communityoutreachdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachdashboard-btn-2')]")
	private WebElement communityoutreachdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachdashboard-btn-3')]")
	private WebElement communityoutreachdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachdashboard-screen')]")
	private WebElement communityoutreachdashboardScreen;

    public Client54CommunityoutreachdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client54CommunityoutreachdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client54CommunityoutreachdashboardscreenScreen", "/offices/marketing/roles/community_outreach/dashboard");
    }
}

