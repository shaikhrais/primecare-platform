package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth129IntakeanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 129;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeanalytics-content')]")
	private WebElement intakeanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeanalytics-btn-2')]")
	private WebElement intakeanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeanalytics-title')]")
	private WebElement intakeanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeanalytics-btn-1')]")
	private WebElement intakeanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeanalytics-screen')]")
	private WebElement intakeanalyticsScreen;

    public Auth129IntakeanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth129IntakeanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth129IntakeanalyticsscreenScreen", "/offices/clinical/roles/intake_coordinator/analytics");
    }
}

