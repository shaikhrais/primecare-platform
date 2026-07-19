package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1002InpatientpharmacyqueuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1002;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'inpatient_pharmacy_queue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'inpatient_pharmacy_queue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'inpatient_pharmacy_queue-content')]")
	private WebElement primaryContent;

    public Clinic1002InpatientpharmacyqueuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1002InpatientpharmacyqueuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1002InpatientpharmacyqueuescreenScreen", "/generated/inpatient-pharmacy-queue");
    }
}
