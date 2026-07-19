package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic994SecurityincidentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 994;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'security_incident_screen_textfield_input_1')]")
	private WebElement securityIncidentScreenTextfieldInput1;

    public Clinic994SecurityincidentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic994SecurityincidentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic994SecurityincidentscreenScreen", "/generated/security-incident");
    }
}
