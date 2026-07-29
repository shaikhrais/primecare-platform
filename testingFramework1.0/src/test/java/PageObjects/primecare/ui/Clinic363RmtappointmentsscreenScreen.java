package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic363RmtappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 363;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_appointments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-btn-2')]")
	private WebElement rmtappointmentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-loading')]")
	private WebElement rmtappointmentsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-btn-3')]")
	private WebElement rmtappointmentsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-screen')]")
	private WebElement rmtappointmentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-content')]")
	private WebElement rmtappointmentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-title')]")
	private WebElement rmtappointmentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtappointments-btn-1')]")
	private WebElement rmtappointmentsBtn1;

    public Clinic363RmtappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic363RmtappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic363RmtappointmentsscreenScreen", "/offices/clinical/roles/rmt/appointments");
    }
}

