package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic928OshaincidentreporterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 928;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'osha_incident_reporter-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'osha_incident_reporter-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'osha_incident_reporter-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'osha_incident_reporter_outlinedbutton_button_1')]")
	private WebElement oshaIncidentReporterOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'osha_incident_reporter_iconbutton_button_1')]")
	private WebElement oshaIncidentReporterIconbuttonButton1;

    public Clinic928OshaincidentreporterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic928OshaincidentreporterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic928OshaincidentreporterscreenScreen", "/generated/osha-incident-reporter");
    }
}
