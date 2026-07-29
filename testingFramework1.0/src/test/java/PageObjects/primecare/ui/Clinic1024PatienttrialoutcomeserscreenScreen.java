package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1024PatienttrialoutcomeserscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1024;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_trial_outcomeser-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_trial_outcomeser-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_trial_outcomeser-content')]")
	private WebElement primaryContent;

    public Clinic1024PatienttrialoutcomeserscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1024PatienttrialoutcomeserscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1024PatienttrialoutcomeserscreenScreen", "/generated/patient-trial-outcomeser");
    }
}

