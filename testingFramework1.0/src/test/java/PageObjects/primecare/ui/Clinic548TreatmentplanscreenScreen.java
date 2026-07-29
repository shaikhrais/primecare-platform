package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic548TreatmentplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 548;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatment_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatment_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatment_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-btn-3')]")
	private WebElement treatmentplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-btn-1')]")
	private WebElement treatmentplanBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-content')]")
	private WebElement treatmentplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-screen')]")
	private WebElement treatmentplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-title')]")
	private WebElement treatmentplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-btn-2')]")
	private WebElement treatmentplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'treatmentplan-loading')]")
	private WebElement treatmentplanLoading;

    public Clinic548TreatmentplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic548TreatmentplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic548TreatmentplanscreenScreen", "/offices/clinical/roles/physiotherapist/treatment-plan");
    }
}

