package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic846QualitymetricsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 846;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_metrics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_metrics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_metrics-content')]")
	private WebElement primaryContent;

    public Clinic846QualitymetricsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic846QualitymetricsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic846QualitymetricsscreenScreen", "/generated/quality-metrics");
    }
}

