package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic346PhysiotherapistappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 346;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_appointments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistappointments-screen')]")
	private WebElement physiotherapistappointmentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistappointments-content')]")
	private WebElement physiotherapistappointmentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistappointments-title')]")
	private WebElement physiotherapistappointmentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistappointments-btn-3')]")
	private WebElement physiotherapistappointmentsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistappointments-btn-2')]")
	private WebElement physiotherapistappointmentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistappointments-btn-1')]")
	private WebElement physiotherapistappointmentsBtn1;

    public Clinic346PhysiotherapistappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic346PhysiotherapistappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic346PhysiotherapistappointmentsscreenScreen", "/offices/clinical/roles/physiotherapist/appointments");
    }
}

