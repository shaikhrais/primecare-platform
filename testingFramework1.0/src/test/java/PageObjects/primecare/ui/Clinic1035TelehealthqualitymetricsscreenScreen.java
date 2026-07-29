package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1035TelehealthqualitymetricsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1035;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telehealth_quality_metrics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telehealth_quality_metrics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'telehealth_quality_metrics-content')]")
	private WebElement primaryContent;

    public Clinic1035TelehealthqualitymetricsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1035TelehealthqualitymetricsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1035TelehealthqualitymetricsscreenScreen", "/generated/telehealth-quality-metrics");
    }
}

