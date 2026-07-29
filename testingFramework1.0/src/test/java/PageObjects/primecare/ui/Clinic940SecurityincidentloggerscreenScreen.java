package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic940SecurityincidentloggerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 940;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident_logger-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident_logger-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident_logger-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident_logger_outlinedbutton_button_1')]")
	private WebElement securityIncidentLoggerOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident_logger_iconbutton_button_1')]")
	private WebElement securityIncidentLoggerIconbuttonButton1;

    public Clinic940SecurityincidentloggerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic940SecurityincidentloggerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic940SecurityincidentloggerscreenScreen", "/generated/security-incident-logger");
    }
}

