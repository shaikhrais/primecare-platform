package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic309ClinicaldirectorincidentreviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 309;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_incident_review-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_incident_review-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_incident_review-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorincidentreview-title')]")
	private WebElement clinicaldirectorincidentreviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorincidentreview-content')]")
	private WebElement clinicaldirectorincidentreviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorincidentreview-btn-1')]")
	private WebElement clinicaldirectorincidentreviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorincidentreview-btn-2')]")
	private WebElement clinicaldirectorincidentreviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorincidentreview-screen')]")
	private WebElement clinicaldirectorincidentreviewScreen;

    public Clinic309ClinicaldirectorincidentreviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic309ClinicaldirectorincidentreviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic309ClinicaldirectorincidentreviewscreenScreen", "/offices/clinical/roles/clinical_director/incident-review");
    }
}
