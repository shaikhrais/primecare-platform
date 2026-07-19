package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic965MedicallibraryaccessportalscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 965;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medical_library_access_portal-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medical_library_access_portal-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medical_library_access_portal-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medical_library_access_portal_iconbutton_button_1')]")
	private WebElement medicalLibraryAccessPortalIconbuttonButton1;

    public Clinic965MedicallibraryaccessportalscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic965MedicallibraryaccessportalscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic965MedicallibraryaccessportalscreenScreen", "/generated/medical-library-access-portal");
    }
}
