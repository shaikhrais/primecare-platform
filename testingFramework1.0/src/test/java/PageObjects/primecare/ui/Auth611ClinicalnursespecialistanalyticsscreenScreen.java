package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth611ClinicalnursespecialistanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 611;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist analytics-title')]")
	private WebElement clinicalnursespecialistanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist analytics-screen')]")
	private WebElement clinicalnursespecialistanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist analytics-btn-1')]")
	private WebElement clinicalnursespecialistanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist analytics-btn-2')]")
	private WebElement clinicalnursespecialistanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical nurse specialist analytics-content')]")
	private WebElement clinicalnursespecialistanalyticsContent;

    public Auth611ClinicalnursespecialistanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth611ClinicalnursespecialistanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth611ClinicalnursespecialistanalyticsscreenScreen", "/rn/cns-analytics");
    }
}

