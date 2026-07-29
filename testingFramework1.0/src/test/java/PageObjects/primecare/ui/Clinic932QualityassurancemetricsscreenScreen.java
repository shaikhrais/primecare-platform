package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic932QualityassurancemetricsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 932;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_metrics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_metrics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_metrics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_metrics_iconbutton_button_1')]")
	private WebElement qualityAssuranceMetricsIconbuttonButton1;

    public Clinic932QualityassurancemetricsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic932QualityassurancemetricsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic932QualityassurancemetricsscreenScreen", "/generated/quality-assurance-metrics");
    }
}

