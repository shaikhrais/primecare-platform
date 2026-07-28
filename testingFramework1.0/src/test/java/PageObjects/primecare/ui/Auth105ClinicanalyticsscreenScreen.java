package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth105ClinicanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 105;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicanalytics-btn-1')]")
	private WebElement clinicanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicanalytics-content')]")
	private WebElement clinicanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicanalytics-title')]")
	private WebElement clinicanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicanalytics-btn-2')]")
	private WebElement clinicanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicanalytics-screen')]")
	private WebElement clinicanalyticsScreen;

    public Auth105ClinicanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth105ClinicanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth105ClinicanalyticsscreenScreen", "/offices/clinical/roles/clinical_director/clinic-analytics");
    }
}

