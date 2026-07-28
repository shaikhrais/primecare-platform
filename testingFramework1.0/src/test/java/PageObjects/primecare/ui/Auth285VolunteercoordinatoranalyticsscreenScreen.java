package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth285VolunteercoordinatoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 285;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatoranalytics-title')]")
	private WebElement volunteercoordinatoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatoranalytics-screen')]")
	private WebElement volunteercoordinatoranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatoranalytics-btn-2')]")
	private WebElement volunteercoordinatoranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatoranalytics-content')]")
	private WebElement volunteercoordinatoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatoranalytics-btn-3')]")
	private WebElement volunteercoordinatoranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatoranalytics-btn-1')]")
	private WebElement volunteercoordinatoranalyticsBtn1;

    public Auth285VolunteercoordinatoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth285VolunteercoordinatoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth285VolunteercoordinatoranalyticsscreenScreen", "/staff/volunteer-coordinator-analytics");
    }
}

