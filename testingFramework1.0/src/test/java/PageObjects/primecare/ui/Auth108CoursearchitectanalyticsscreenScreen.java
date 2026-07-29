package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth108CoursearchitectanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 108;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectanalytics-content')]")
	private WebElement coursearchitectanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectanalytics-btn-1')]")
	private WebElement coursearchitectanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectanalytics-title')]")
	private WebElement coursearchitectanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectanalytics-screen')]")
	private WebElement coursearchitectanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectanalytics-btn-2')]")
	private WebElement coursearchitectanalyticsBtn2;

    public Auth108CoursearchitectanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth108CoursearchitectanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth108CoursearchitectanalyticsscreenScreen", "/common/course-architect-analytics");
    }
}

