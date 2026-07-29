package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth96ArchitectureplanninganalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 96;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanninganalytics-btn-2')]")
	private WebElement architectureplanninganalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanninganalytics-content')]")
	private WebElement architectureplanninganalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanninganalytics-btn-1')]")
	private WebElement architectureplanninganalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanninganalytics-screen')]")
	private WebElement architectureplanninganalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanninganalytics-title')]")
	private WebElement architectureplanninganalyticsTitle;

    public Auth96ArchitectureplanninganalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth96ArchitectureplanninganalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth96ArchitectureplanninganalyticsscreenScreen", "/common/architecture-planning-analytics");
    }
}

