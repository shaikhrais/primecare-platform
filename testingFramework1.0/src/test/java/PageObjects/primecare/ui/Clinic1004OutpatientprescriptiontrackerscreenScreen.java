package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1004OutpatientprescriptiontrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1004;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outpatient_prescription_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outpatient_prescription_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'outpatient_prescription_tracker-content')]")
	private WebElement primaryContent;

    public Clinic1004OutpatientprescriptiontrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1004OutpatientprescriptiontrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1004OutpatientprescriptiontrackerscreenScreen", "/generated/outpatient-prescription-tracker");
    }
}

