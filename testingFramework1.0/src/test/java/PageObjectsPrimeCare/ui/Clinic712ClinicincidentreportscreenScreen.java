package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic712ClinicincidentreportscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 712;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_incident_report-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_incident_report-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_incident_report-content')]")
	private WebElement primaryContent;

    public Clinic712ClinicincidentreportscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic712ClinicincidentreportscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic712ClinicincidentreportscreenScreen", "/generated/clinic-incident-report");
    }
}
