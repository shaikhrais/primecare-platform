package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic61PswDashboardScreen extends baseTest {
 
    public static final int SCREEN_ID = 61;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'psw-shift-status-card')]")
    public WebElement pswShiftStatusCard;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'psw-start-shift-btn')]")
    public WebElement pswStartShiftBtn;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'psw-report-incident-btn')]")
    public WebElement pswReportIncidentBtn;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'psw-view-vitals-btn')]")
    public WebElement pswViewVitalsBtn;
 
    @FindBy(xpath = "//*[starts-with(@aria-label, 'psw-clients-list')]")
    public WebElement pswClientsList;
 
    public Clinic61PswDashboardScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic61PswDashboardScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic61PswDashboardScreen", "/offices/clinical/roles/psw/dashboard");
    }
}

