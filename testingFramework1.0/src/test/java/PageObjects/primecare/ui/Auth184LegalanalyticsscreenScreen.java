package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth184LegalanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 184;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-loading')]")
	private WebElement legalanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-btn-2')]")
	private WebElement legalanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-screen')]")
	private WebElement legalanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-content')]")
	private WebElement legalanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-btn-1')]")
	private WebElement legalanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-title')]")
	private WebElement legalanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalanalytics-btn-3')]")
	private WebElement legalanalyticsBtn3;

    public Auth184LegalanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth184LegalanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth184LegalanalyticsscreenScreen", "/executive/legal-analytics");
    }
}

