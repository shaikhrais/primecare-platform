package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client497IncidentmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 497;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentmanagement-screen')]")
	private WebElement incidentmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentmanagement-content')]")
	private WebElement incidentmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentmanagement-title')]")
	private WebElement incidentmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentmanagement-btn-1')]")
	private WebElement incidentmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentmanagement-btn-2')]")
	private WebElement incidentmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incidentmanagement-btn-3')]")
	private WebElement incidentmanagementBtn3;

    public Client497IncidentmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client497IncidentmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client497IncidentmanagementscreenScreen", "/management/incident-management");
    }
}

