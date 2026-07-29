package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client339PatientappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 339;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_appointments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientappointments-screen')]")
	private WebElement patientappointmentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientappointments-title')]")
	private WebElement patientappointmentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientappointments-btn-2')]")
	private WebElement patientappointmentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientappointments-btn-1')]")
	private WebElement patientappointmentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientappointments-btn-3')]")
	private WebElement patientappointmentsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientappointments-content')]")
	private WebElement patientappointmentsContent;

    public Client339PatientappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client339PatientappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client339PatientappointmentsscreenScreen", "/common/patient-appointments");
    }
}

