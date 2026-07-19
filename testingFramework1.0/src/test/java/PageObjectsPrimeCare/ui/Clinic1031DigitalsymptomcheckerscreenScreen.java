package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1031DigitalsymptomcheckerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1031;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'digital_symptom_checker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'digital_symptom_checker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'digital_symptom_checker-content')]")
	private WebElement primaryContent;

    public Clinic1031DigitalsymptomcheckerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1031DigitalsymptomcheckerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1031DigitalsymptomcheckerscreenScreen", "/generated/digital-symptom-checker");
    }
}
