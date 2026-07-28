package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic924IncidentresponsehubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 924;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_response_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_response_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_response_hub-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_response_hub_iconbutton_button_1')]")
	private WebElement incidentResponseHubIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_response_hub_outlinedbutton_button_1')]")
	private WebElement incidentResponseHubOutlinedbuttonButton1;

    public Clinic924IncidentresponsehubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic924IncidentresponsehubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic924IncidentresponsehubscreenScreen", "/generated/incident-response-hub");
    }
}

