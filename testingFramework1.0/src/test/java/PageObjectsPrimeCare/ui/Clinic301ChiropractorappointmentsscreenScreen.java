package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic301ChiropractorappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 301;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_appointments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorappointments-content')]")
	private WebElement chiropractorappointmentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorappointments-btn-1')]")
	private WebElement chiropractorappointmentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorappointments-screen')]")
	private WebElement chiropractorappointmentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorappointments-btn-3')]")
	private WebElement chiropractorappointmentsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorappointments-btn-2')]")
	private WebElement chiropractorappointmentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorappointments-title')]")
	private WebElement chiropractorappointmentsTitle;

    public Clinic301ChiropractorappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic301ChiropractorappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic301ChiropractorappointmentsscreenScreen", "/offices/clinical/roles/chiropractor/appointments");
    }
}
