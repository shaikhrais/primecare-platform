package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic358ReportincidentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 358;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_incident_report-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_incident_report-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_incident_report-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-screen')]")
	private WebElement pswincidentreportScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-loading')]")
	private WebElement pswincidentreportLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-btn-3')]")
	private WebElement pswincidentreportBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-btn-1')]")
	private WebElement pswincidentreportBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-title')]")
	private WebElement pswincidentreportTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-content')]")
	private WebElement pswincidentreportContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswincidentreport-btn-2')]")
	private WebElement pswincidentreportBtn2;

    public Clinic358ReportincidentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic358ReportincidentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic358ReportincidentscreenScreen", "/offices/clinical/roles/psw/incident-report");
    }
}

