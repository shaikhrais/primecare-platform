package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class BusinessDevelopment507GrowthanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 507;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growth_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growth_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growth_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-loading')]")
	private WebElement growthanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-title')]")
	private WebElement growthanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-btn-2')]")
	private WebElement growthanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-btn-3')]")
	private WebElement growthanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-content')]")
	private WebElement growthanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-screen')]")
	private WebElement growthanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'growthanalytics-btn-1')]")
	private WebElement growthanalyticsBtn1;

    public BusinessDevelopment507GrowthanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public BusinessDevelopment507GrowthanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "BusinessDevelopment507GrowthanalyticsscreenScreen", "/management/growth-analytics");
    }
}
