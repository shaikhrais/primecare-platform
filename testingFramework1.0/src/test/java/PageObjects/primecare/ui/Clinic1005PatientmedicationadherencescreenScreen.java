package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1005PatientmedicationadherencescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1005;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_medication_adherence-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_medication_adherence-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_medication_adherence-content')]")
	private WebElement primaryContent;

    public Clinic1005PatientmedicationadherencescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1005PatientmedicationadherencescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1005PatientmedicationadherencescreenScreen", "/generated/patient-medication-adherence");
    }
}

