package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client341PatientmessagesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 341;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_messages-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_messages-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_messages-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-loading')]")
	private WebElement patientmessagesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-btn-2')]")
	private WebElement patientmessagesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-title')]")
	private WebElement patientmessagesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-content')]")
	private WebElement patientmessagesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-screen')]")
	private WebElement patientmessagesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-btn-1')]")
	private WebElement patientmessagesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientmessages-btn-3')]")
	private WebElement patientmessagesBtn3;

    public Client341PatientmessagesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client341PatientmessagesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client341PatientmessagesscreenScreen", "/common/patient-messages");
    }
}

