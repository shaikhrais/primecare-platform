package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1018AdverseeventreportingportalscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1018;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adverse_event_reporting_portal-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adverse_event_reporting_portal-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'adverse_event_reporting_portal-content')]")
	private WebElement primaryContent;

    public Clinic1018AdverseeventreportingportalscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1018AdverseeventreportingportalscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1018AdverseeventreportingportalscreenScreen", "/generated/adverse-event-reporting-portal");
    }
}

