package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic566IncidentoversightscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 566;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_oversight-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_oversight-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_oversight-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-content')]")
	private WebElement incidentoversightContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-btn-1')]")
	private WebElement incidentoversightBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-btn-3')]")
	private WebElement incidentoversightBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-loading')]")
	private WebElement incidentoversightLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-title')]")
	private WebElement incidentoversightTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-btn-2')]")
	private WebElement incidentoversightBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentoversight-screen')]")
	private WebElement incidentoversightScreen;

    public Clinic566IncidentoversightscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic566IncidentoversightscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic566IncidentoversightscreenScreen", "/offices/clinical/roles/clinical_director/incident-oversight");
    }
}

