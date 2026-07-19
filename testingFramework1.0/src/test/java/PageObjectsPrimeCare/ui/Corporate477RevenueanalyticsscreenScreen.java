package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate477RevenueanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 477;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenue_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-title')]")
	private WebElement revenueanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-btn-3')]")
	private WebElement revenueanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-btn-2')]")
	private WebElement revenueanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-screen')]")
	private WebElement revenueanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-content')]")
	private WebElement revenueanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-btn-1')]")
	private WebElement revenueanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'revenueanalytics-loading')]")
	private WebElement revenueanalyticsLoading;

    public Corporate477RevenueanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate477RevenueanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate477RevenueanalyticsscreenScreen", "/executive/revenue-analytics");
    }
}
