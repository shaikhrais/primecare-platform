package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise334FranchiseownerappointmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 334;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_appointments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_appointments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_appointments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerappointments-screen')]")
	private WebElement franchiseownerappointmentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerappointments-title')]")
	private WebElement franchiseownerappointmentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerappointments-btn-1')]")
	private WebElement franchiseownerappointmentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerappointments-btn-2')]")
	private WebElement franchiseownerappointmentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerappointments-content')]")
	private WebElement franchiseownerappointmentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerappointments-btn-3')]")
	private WebElement franchiseownerappointmentsBtn3;

    public Franchise334FranchiseownerappointmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise334FranchiseownerappointmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise334FranchiseownerappointmentsscreenScreen", "/offices/franchise/roles/franchise_owner/appointments");
    }
}

