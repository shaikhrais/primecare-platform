package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth94HswincidentreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 94;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_incident_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_incident_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_incident_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-incident-form-fields')]")
	private WebElement dataCyHswIncidentFormFields;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswincidentreports-content')]")
	private WebElement hswincidentreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'submit_incident_report')]")
	private WebElement submitIncidentReport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-witness-notes-input')]")
	private WebElement dataCyHswWitnessNotesInput;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswincidentreports-screen')]")
	private WebElement hswincidentreportsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-hsw-incident-severity-picker')]")
	private WebElement dataCyHswIncidentSeverityPicker;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswincidentreports-btn-1')]")
	private WebElement hswincidentreportsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswincidentreports-title')]")
	private WebElement hswincidentreportsTitle;

    public Auth94HswincidentreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth94HswincidentreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth94HswincidentreportsscreenScreen", "/clinical/hsw-incident-reports");
    }
}

