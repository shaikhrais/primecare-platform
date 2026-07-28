package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic952PatientretentionanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 952;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_retention_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_retention_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_retention_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_retention_analytics_iconbutton_button_1')]")
	private WebElement patientRetentionAnalyticsIconbuttonButton1;

    public Clinic952PatientretentionanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic952PatientretentionanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic952PatientretentionanalyticsscreenScreen", "/generated/patient-retention-analytics");
    }
}

