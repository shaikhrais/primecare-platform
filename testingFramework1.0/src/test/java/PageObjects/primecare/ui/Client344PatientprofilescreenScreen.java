package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client344PatientprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 344;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-title')]")
	private WebElement patientprofileTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-screen')]")
	private WebElement patientprofileScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-btn-1')]")
	private WebElement patientprofileBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-content')]")
	private WebElement patientprofileContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-btn-2')]")
	private WebElement patientprofileBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-loading')]")
	private WebElement patientprofileLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientprofile-btn-3')]")
	private WebElement patientprofileBtn3;

    public Client344PatientprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client344PatientprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client344PatientprofilescreenScreen", "/offices/client/roles/client/profile");
    }
}

