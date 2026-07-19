package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth232ScrummasteranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 232;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-screen')]")
	private WebElement scrummasteranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-btn-2')]")
	private WebElement scrummasteranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-title')]")
	private WebElement scrummasteranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-btn-3')]")
	private WebElement scrummasteranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-content')]")
	private WebElement scrummasteranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-loading')]")
	private WebElement scrummasteranalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasteranalytics-btn-1')]")
	private WebElement scrummasteranalyticsBtn1;

    public Auth232ScrummasteranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth232ScrummasteranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth232ScrummasteranalyticsscreenScreen", "/management/scrum-master-analytics");
    }
}
