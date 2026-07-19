package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client340PatientcareplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 340;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_care_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_care_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_care_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-btn-2')]")
	private WebElement patientcareplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-loading')]")
	private WebElement patientcareplanLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-btn-3')]")
	private WebElement patientcareplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-title')]")
	private WebElement patientcareplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-content')]")
	private WebElement patientcareplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-btn-1')]")
	private WebElement patientcareplanBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareplan-screen')]")
	private WebElement patientcareplanScreen;

    public Client340PatientcareplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client340PatientcareplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client340PatientcareplanscreenScreen", "/common/patient-care-plan");
    }
}
