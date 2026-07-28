package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth196CommunityoutreachanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 196;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'community_outreach_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-loading')]")
	private WebElement communityoutreachanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-content')]")
	private WebElement communityoutreachanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-title')]")
	private WebElement communityoutreachanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-screen')]")
	private WebElement communityoutreachanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-btn-2')]")
	private WebElement communityoutreachanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-btn-3')]")
	private WebElement communityoutreachanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'communityoutreachanalytics-btn-1')]")
	private WebElement communityoutreachanalyticsBtn1;

    public Auth196CommunityoutreachanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth196CommunityoutreachanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth196CommunityoutreachanalyticsscreenScreen", "/management/community-outreach-analytics");
    }
}

