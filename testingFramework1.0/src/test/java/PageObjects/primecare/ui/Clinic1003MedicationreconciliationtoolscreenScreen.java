package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1003MedicationreconciliationtoolscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1003;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication_reconciliation_tool-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication_reconciliation_tool-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'medication_reconciliation_tool-content')]")
	private WebElement primaryContent;

    public Clinic1003MedicationreconciliationtoolscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1003MedicationreconciliationtoolscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1003MedicationreconciliationtoolscreenScreen", "/generated/medication-reconciliation-tool");
    }
}

