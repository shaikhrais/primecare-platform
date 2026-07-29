package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth282TrainingcoordinatoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 282;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatoranalytics-content')]")
	private WebElement trainingcoordinatoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatoranalytics-screen')]")
	private WebElement trainingcoordinatoranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatoranalytics-title')]")
	private WebElement trainingcoordinatoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatoranalytics-btn-1')]")
	private WebElement trainingcoordinatoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatoranalytics-btn-3')]")
	private WebElement trainingcoordinatoranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatoranalytics-btn-2')]")
	private WebElement trainingcoordinatoranalyticsBtn2;

    public Auth282TrainingcoordinatoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth282TrainingcoordinatoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth282TrainingcoordinatoranalyticsscreenScreen", "/staff/training-coordinator-analytics");
    }
}

