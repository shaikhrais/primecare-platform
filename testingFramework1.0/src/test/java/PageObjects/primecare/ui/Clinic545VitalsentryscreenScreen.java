package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic545VitalsentryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 545;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitals_entry-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitals_entry-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitals_entry-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-screen')]")
	private WebElement vitalsentryScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-loading')]")
	private WebElement vitalsentryLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-btn-3')]")
	private WebElement vitalsentryBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-title')]")
	private WebElement vitalsentryTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-btn-1')]")
	private WebElement vitalsentryBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-content')]")
	private WebElement vitalsentryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vitalsentry-btn-2')]")
	private WebElement vitalsentryBtn2;

    public Clinic545VitalsentryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic545VitalsentryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic545VitalsentryscreenScreen", "/offices/clinical/roles/psw/vitals-entry");
    }
}

