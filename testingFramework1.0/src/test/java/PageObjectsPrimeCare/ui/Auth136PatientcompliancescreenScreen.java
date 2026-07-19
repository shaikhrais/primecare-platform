package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth136PatientcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 136;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-content')]")
	private WebElement patientcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-loading')]")
	private WebElement patientcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-btn-1')]")
	private WebElement patientcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-btn-3')]")
	private WebElement patientcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-screen')]")
	private WebElement patientcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-title')]")
	private WebElement patientcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcompliance-btn-2')]")
	private WebElement patientcomplianceBtn2;

    public Auth136PatientcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth136PatientcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth136PatientcompliancescreenScreen", "/common/patient-compliance");
    }
}
