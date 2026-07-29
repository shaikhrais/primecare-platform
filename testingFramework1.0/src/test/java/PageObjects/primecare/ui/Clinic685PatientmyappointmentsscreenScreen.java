package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic685PatientmyappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 685;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_my_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_my_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_my_appointments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmyappointmentsscreen-screen')]")
	private WebElement patientmyappointmentsscreenScreen;

    public Clinic685PatientmyappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic685PatientmyappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic685PatientmyappointmentsscreenScreen", "/offices/client/roles/client/my-appointments");
    }
}

