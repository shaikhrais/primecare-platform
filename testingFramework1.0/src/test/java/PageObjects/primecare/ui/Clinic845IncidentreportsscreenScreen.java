package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic845IncidentreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 845;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'incident_reports-content')]")
	private WebElement primaryContent;

    public Clinic845IncidentreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic845IncidentreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic845IncidentreportsscreenScreen", "/generated/incident-reports");
    }
}

