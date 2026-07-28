package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client343PatientbillingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 343;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_billing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_billing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_billing-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-btn-2')]")
	private WebElement patientbillingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-btn-1')]")
	private WebElement patientbillingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-content')]")
	private WebElement patientbillingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-btn-3')]")
	private WebElement patientbillingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-screen')]")
	private WebElement patientbillingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-title')]")
	private WebElement patientbillingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientbilling-loading')]")
	private WebElement patientbillingLoading;

    public Client343PatientbillingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client343PatientbillingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client343PatientbillingscreenScreen", "/common/patient-billing");
    }
}

