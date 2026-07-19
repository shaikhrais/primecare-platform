package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic711ClinichistorylogsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 711;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_history_logs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_history_logs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_history_logs-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinichistorylogsscreen-screen')]")
	private WebElement clinichistorylogsscreenScreen;

    public Clinic711ClinichistorylogsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic711ClinichistorylogsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic711ClinichistorylogsscreenScreen", "/generated/clinic-history-logs");
    }
}
