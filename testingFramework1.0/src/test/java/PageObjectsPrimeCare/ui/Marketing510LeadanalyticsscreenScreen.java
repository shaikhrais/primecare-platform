package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Marketing510LeadanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 510;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lead_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-loading')]")
	private WebElement leadanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-screen')]")
	private WebElement leadanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-btn-2')]")
	private WebElement leadanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-title')]")
	private WebElement leadanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-content')]")
	private WebElement leadanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-btn-3')]")
	private WebElement leadanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'leadanalytics-btn-1')]")
	private WebElement leadanalyticsBtn1;

    public Marketing510LeadanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Marketing510LeadanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Marketing510LeadanalyticsscreenScreen", "/management/lead-analytics");
    }
}
