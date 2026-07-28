package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic697PswobservationvitalslogscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 697;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_observation_vitals_log-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_observation_vitals_log-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_observation_vitals_log-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswobservationvitalslogscreen-screen')]")
	private WebElement pswobservationvitalslogscreenScreen;

    public Clinic697PswobservationvitalslogscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic697PswobservationvitalslogscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic697PswobservationvitalslogscreenScreen", "/generated/psw-observation-vitals-log");
    }
}

