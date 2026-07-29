package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic966PatientcasestudyrepositoryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 966;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_case_study_repository-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_case_study_repository-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_case_study_repository-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_case_study_repository_textbutton_button_1')]")
	private WebElement patientCaseStudyRepositoryTextbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_case_study_repository_iconbutton_button_1')]")
	private WebElement patientCaseStudyRepositoryIconbuttonButton1;

    public Clinic966PatientcasestudyrepositoryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic966PatientcasestudyrepositoryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic966PatientcasestudyrepositoryscreenScreen", "/generated/patient-case-study-repository");
    }
}

