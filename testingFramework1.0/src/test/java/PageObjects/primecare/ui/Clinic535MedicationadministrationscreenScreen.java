package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic535MedicationadministrationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 535;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication_administration-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication_administration-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication_administration-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medicationadministration-btn-3')]")
	private WebElement medicationadministrationBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medicationadministration-btn-1')]")
	private WebElement medicationadministrationBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medicationadministration-btn-2')]")
	private WebElement medicationadministrationBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medicationadministration-screen')]")
	private WebElement medicationadministrationScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medicationadministration-content')]")
	private WebElement medicationadministrationContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medicationadministration-title')]")
	private WebElement medicationadministrationTitle;

    public Clinic535MedicationadministrationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic535MedicationadministrationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic535MedicationadministrationscreenScreen", "/offices/clinical/roles/rn/medication-administration");
    }
}

