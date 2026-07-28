package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth137PatientworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 137;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientworkflow-btn-1')]")
	private WebElement patientworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientworkflow-screen')]")
	private WebElement patientworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientworkflow-btn-2')]")
	private WebElement patientworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientworkflow-content')]")
	private WebElement patientworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientworkflow-title')]")
	private WebElement patientworkflowTitle;

    public Auth137PatientworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth137PatientworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth137PatientworkflowscreenScreen", "/common/patient-workflow");
    }
}

