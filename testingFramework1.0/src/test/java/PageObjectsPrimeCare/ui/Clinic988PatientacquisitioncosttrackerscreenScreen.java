package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic988PatientacquisitioncosttrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 988;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_acquisition_cost_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_acquisition_cost_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_acquisition_cost_tracker-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_acquisition_cost_tracker_iconbutton_button_1')]")
	private WebElement patientAcquisitionCostTrackerIconbuttonButton1;

    public Clinic988PatientacquisitioncosttrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic988PatientacquisitioncosttrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic988PatientacquisitioncosttrackerscreenScreen", "/generated/patient-acquisition-cost-tracker");
    }
}
