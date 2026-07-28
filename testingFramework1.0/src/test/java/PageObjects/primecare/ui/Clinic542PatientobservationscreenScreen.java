package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic542PatientobservationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 542;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_observation-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_observation-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_observation-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientobservation-screen')]")
	private WebElement patientobservationScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientobservation-btn-3')]")
	private WebElement patientobservationBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientobservation-title')]")
	private WebElement patientobservationTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientobservation-content')]")
	private WebElement patientobservationContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientobservation-btn-1')]")
	private WebElement patientobservationBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientobservation-btn-2')]")
	private WebElement patientobservationBtn2;

    public Clinic542PatientobservationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic542PatientobservationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic542PatientobservationscreenScreen", "/offices/clinical/roles/rpn/patient-observation");
    }
}

