package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic683PatientbookappointmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 683;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_book_appointment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_book_appointment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_book_appointment-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbookappointmentscreen-screen')]")
	private WebElement patientbookappointmentscreenScreen;

    public Clinic683PatientbookappointmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic683PatientbookappointmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic683PatientbookappointmentscreenScreen", "/offices/client/roles/client/book-appointment");
    }
}
