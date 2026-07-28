package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth89ClinicalanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 89;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalanalytics-content')]")
	private WebElement clinicalanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalanalytics-title')]")
	private WebElement clinicalanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalanalytics-btn-1')]")
	private WebElement clinicalanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalanalytics-btn-2')]")
	private WebElement clinicalanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalanalytics-screen')]")
	private WebElement clinicalanalyticsScreen;

    public Auth89ClinicalanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth89ClinicalanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth89ClinicalanalyticsscreenScreen", "/offices/clinical/roles/clinical_director/analytics");
    }
}

