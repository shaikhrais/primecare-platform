package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth175CxdirectoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 175;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectoranalytics-title')]")
	private WebElement cxdirectoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectoranalytics-btn-3')]")
	private WebElement cxdirectoranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectoranalytics-btn-1')]")
	private WebElement cxdirectoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectoranalytics-screen')]")
	private WebElement cxdirectoranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectoranalytics-content')]")
	private WebElement cxdirectoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectoranalytics-btn-2')]")
	private WebElement cxdirectoranalyticsBtn2;

    public Auth175CxdirectoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth175CxdirectoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth175CxdirectoranalyticsscreenScreen", "/executive/cx-director-analytics");
    }
}
