package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth279ScheduleranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 279;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleranalytics-btn-3')]")
	private WebElement scheduleranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleranalytics-btn-2')]")
	private WebElement scheduleranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleranalytics-content')]")
	private WebElement scheduleranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleranalytics-screen')]")
	private WebElement scheduleranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleranalytics-title')]")
	private WebElement scheduleranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduleranalytics-btn-1')]")
	private WebElement scheduleranalyticsBtn1;

    public Auth279ScheduleranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth279ScheduleranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth279ScheduleranalyticsscreenScreen", "/staff/scheduler-analytics");
    }
}

