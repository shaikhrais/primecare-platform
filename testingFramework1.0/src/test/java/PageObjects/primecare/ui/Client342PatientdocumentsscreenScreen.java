package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client342PatientdocumentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 342;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_documents-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_documents-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_documents-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-btn-2')]")
	private WebElement patientdocumentsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-title')]")
	private WebElement patientdocumentsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-content')]")
	private WebElement patientdocumentsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-loading')]")
	private WebElement patientdocumentsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-btn-1')]")
	private WebElement patientdocumentsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-screen')]")
	private WebElement patientdocumentsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientdocuments-btn-3')]")
	private WebElement patientdocumentsBtn3;

    public Client342PatientdocumentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client342PatientdocumentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client342PatientdocumentsscreenScreen", "/common/patient-documents");
    }
}

