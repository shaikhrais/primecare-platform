package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client34PatientdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 34;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-btn-1')]")
	private WebElement patientdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-btn-3')]")
	private WebElement patientdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-screen')]")
	private WebElement patientdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-loading')]")
	private WebElement patientdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-content')]")
	private WebElement patientdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-title')]")
	private WebElement patientdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdashboard-btn-2')]")
	private WebElement patientdashboardBtn2;

    public Client34PatientdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client34PatientdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client34PatientdashboardscreenScreen", "/offices/client/roles/client/dashboard");
    }
}
