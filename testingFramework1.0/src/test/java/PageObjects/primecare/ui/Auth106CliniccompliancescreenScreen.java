package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth106CliniccompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 106;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-loading')]")
	private WebElement cliniccomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-btn-3')]")
	private WebElement cliniccomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-content')]")
	private WebElement cliniccomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-screen')]")
	private WebElement cliniccomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-btn-1')]")
	private WebElement cliniccomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-title')]")
	private WebElement cliniccomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cliniccompliance-btn-2')]")
	private WebElement cliniccomplianceBtn2;

    public Auth106CliniccompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth106CliniccompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth106CliniccompliancescreenScreen", "/offices/clinical/roles/clinical_director/clinic-compliance");
    }
}

