package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth135PatientanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 135;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientanalytics-screen')]")
	private WebElement patientanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientanalytics-content')]")
	private WebElement patientanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientanalytics-btn-1')]")
	private WebElement patientanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientanalytics-title')]")
	private WebElement patientanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientanalytics-btn-2')]")
	private WebElement patientanalyticsBtn2;

    public Auth135PatientanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth135PatientanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth135PatientanalyticsscreenScreen", "/common/patient-analytics");
    }
}

