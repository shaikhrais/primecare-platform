package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic686PatientpaymentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 686;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_payments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_payments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_payments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientpaymentsscreen-screen')]")
	private WebElement patientpaymentsscreenScreen;

    public Clinic686PatientpaymentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic686PatientpaymentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic686PatientpaymentsscreenScreen", "/offices/client/roles/client/payments");
    }
}
