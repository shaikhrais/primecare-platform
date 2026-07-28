package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic689ClinicaldirectorqualitymetricsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 689;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_quality_metrics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_quality_metrics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_director_quality_metrics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicaldirectorqualitymetricsscreen-screen')]")
	private WebElement clinicaldirectorqualitymetricsscreenScreen;

    public Clinic689ClinicaldirectorqualitymetricsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic689ClinicaldirectorqualitymetricsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic689ClinicaldirectorqualitymetricsscreenScreen", "/generated/clinical-director-quality-metrics");
    }
}

