package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth270IntakecoordinatoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 270;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatoranalytics-btn-3')]")
	private WebElement intakecoordinatoranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatoranalytics-content')]")
	private WebElement intakecoordinatoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatoranalytics-btn-2')]")
	private WebElement intakecoordinatoranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatoranalytics-btn-1')]")
	private WebElement intakecoordinatoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatoranalytics-title')]")
	private WebElement intakecoordinatoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatoranalytics-screen')]")
	private WebElement intakecoordinatoranalyticsScreen;

    public Auth270IntakecoordinatoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth270IntakecoordinatoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth270IntakecoordinatoranalyticsscreenScreen", "/offices/clinical/roles/intake_coordinator/coordinator-analytics");
    }
}

