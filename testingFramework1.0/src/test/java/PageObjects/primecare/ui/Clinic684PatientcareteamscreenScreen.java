package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic684PatientcareteamscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 684;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_care_team-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_care_team-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_care_team-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcareteamscreen-screen')]")
	private WebElement patientcareteamscreenScreen;

    public Clinic684PatientcareteamscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic684PatientcareteamscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic684PatientcareteamscreenScreen", "/offices/client/roles/client/care-team");
    }
}

