package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1036TelemedicineprescriptionpadscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1036;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telemedicine_prescription_pad-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telemedicine_prescription_pad-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telemedicine_prescription_pad-content')]")
	private WebElement primaryContent;

    public Clinic1036TelemedicineprescriptionpadscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1036TelemedicineprescriptionpadscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1036TelemedicineprescriptionpadscreenScreen", "/generated/telemedicine-prescription-pad");
    }
}

