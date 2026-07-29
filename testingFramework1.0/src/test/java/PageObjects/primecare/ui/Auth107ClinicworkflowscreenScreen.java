package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth107ClinicworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 107;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinic_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicworkflow-screen')]")
	private WebElement clinicworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicworkflow-content')]")
	private WebElement clinicworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicworkflow-btn-1')]")
	private WebElement clinicworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicworkflow-title')]")
	private WebElement clinicworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicworkflow-btn-2')]")
	private WebElement clinicworkflowBtn2;

    public Auth107ClinicworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth107ClinicworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth107ClinicworkflowscreenScreen", "/offices/clinical/roles/clinical_director/clinic-workflow");
    }
}

