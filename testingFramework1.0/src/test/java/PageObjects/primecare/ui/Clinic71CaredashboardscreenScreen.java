package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic71CaredashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 71;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-shift-status-card')]")
	private WebElement pswShiftStatusCard;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-start-shift-btn')]")
	private WebElement pswStartShiftBtn;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-report-incident-btn')]")
	private WebElement pswReportIncidentBtn;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-view-vitals-btn')]")
	private WebElement pswViewVitalsBtn;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-clients-list')]")
	private WebElement pswClientsList;

    public Clinic71CaredashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic71CaredashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic71CaredashboardscreenScreen", "/offices/clinical/roles/psw/dashboard");
    }
}

