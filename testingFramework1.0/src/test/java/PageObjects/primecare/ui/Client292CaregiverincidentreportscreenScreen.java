package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client292CaregiverincidentreportscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 292;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_incident_report-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_incident_report-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_incident_report-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverincidentreport-btn-3')]")
	private WebElement caregiverincidentreportBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverincidentreport-btn-2')]")
	private WebElement caregiverincidentreportBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverincidentreport-title')]")
	private WebElement caregiverincidentreportTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverincidentreport-btn-1')]")
	private WebElement caregiverincidentreportBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverincidentreport-screen')]")
	private WebElement caregiverincidentreportScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverincidentreport-content')]")
	private WebElement caregiverincidentreportContent;

    public Client292CaregiverincidentreportscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client292CaregiverincidentreportscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client292CaregiverincidentreportscreenScreen", "/offices/clinical/roles/caregiver/incident-report");
    }
}

