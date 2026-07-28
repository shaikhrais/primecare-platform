package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic541MedicationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 541;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-btn-1')]")
	private WebElement medicationBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-loading')]")
	private WebElement medicationLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-btn-2')]")
	private WebElement medicationBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication-btn-3')]")
	private WebElement medicationBtn3;

    public Clinic541MedicationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic541MedicationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic541MedicationscreenScreen", "/offices/clinical/roles/rpn/medication");
    }
}

