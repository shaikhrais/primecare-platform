package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client338PatientcommandcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 338;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_command_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_command_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patient_command_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcommandcenter-screen')]")
	private WebElement patientcommandcenterScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcommandcenter-btn-1')]")
	private WebElement patientcommandcenterBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcommandcenter-title')]")
	private WebElement patientcommandcenterTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcommandcenter-content')]")
	private WebElement patientcommandcenterContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcommandcenter-btn-2')]")
	private WebElement patientcommandcenterBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'patientcommandcenter-btn-3')]")
	private WebElement patientcommandcenterBtn3;

    public Client338PatientcommandcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client338PatientcommandcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client338PatientcommandcenterscreenScreen", "/common/patient-command-center");
    }
}

