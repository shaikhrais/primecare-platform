package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic687PatienttreatmenthistoryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 687;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_treatment_history-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_treatment_history-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_treatment_history-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patienttreatmenthistoryscreen-screen')]")
	private WebElement patienttreatmenthistoryscreenScreen;

    public Clinic687PatienttreatmenthistoryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic687PatienttreatmenthistoryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic687PatienttreatmenthistoryscreenScreen", "/offices/client/roles/client/treatment-history");
    }
}
