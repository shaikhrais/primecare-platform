package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic704PswcaredashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 704;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_care_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_care_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_care_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcaredashboard-content')]")
	private WebElement pswcaredashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-dashboard-btn-generate-report')]")
	private WebElement pswDashboardBtnGenerateReport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-dashboard-btn-update-record')]")
	private WebElement pswDashboardBtnUpdateRecord;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-dashboard-btn-collaborate')]")
	private WebElement pswDashboardBtnCollaborate;

    public Clinic704PswcaredashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic704PswcaredashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic704PswcaredashboardscreenScreen", "/generated/psw-care-dashboard");
    }
}
