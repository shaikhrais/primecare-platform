package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth607TherapistanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 607;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-btn-3')]")
	private WebElement therapistanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-btn-1')]")
	private WebElement therapistanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-loading')]")
	private WebElement therapistanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-title')]")
	private WebElement therapistanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-content')]")
	private WebElement therapistanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-btn-2')]")
	private WebElement therapistanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist analytics-screen')]")
	private WebElement therapistanalyticsScreen;

    public Auth607TherapistanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth607TherapistanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth607TherapistanalyticsscreenScreen", "/offices/clinical/roles/therapist/analytics");
    }
}

