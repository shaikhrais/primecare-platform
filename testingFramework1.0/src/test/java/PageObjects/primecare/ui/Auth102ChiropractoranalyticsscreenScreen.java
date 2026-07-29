package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth102ChiropractoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 102;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractoranalytics-content')]")
	private WebElement chiropractoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractoranalytics-screen')]")
	private WebElement chiropractoranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractoranalytics-title')]")
	private WebElement chiropractoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractoranalytics-btn-1')]")
	private WebElement chiropractoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractoranalytics-btn-2')]")
	private WebElement chiropractoranalyticsBtn2;

    public Auth102ChiropractoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth102ChiropractoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth102ChiropractoranalyticsscreenScreen", "/offices/clinical/roles/chiropractor/analytics");
    }
}

