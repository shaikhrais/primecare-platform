package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth273QualityassuranceanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 273;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceanalytics-screen')]")
	private WebElement qualityassuranceanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceanalytics-btn-1')]")
	private WebElement qualityassuranceanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceanalytics-title')]")
	private WebElement qualityassuranceanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceanalytics-content')]")
	private WebElement qualityassuranceanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceanalytics-btn-3')]")
	private WebElement qualityassuranceanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceanalytics-btn-2')]")
	private WebElement qualityassuranceanalyticsBtn2;

    public Auth273QualityassuranceanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth273QualityassuranceanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth273QualityassuranceanalyticsscreenScreen", "/staff/quality-assurance-analytics");
    }
}

