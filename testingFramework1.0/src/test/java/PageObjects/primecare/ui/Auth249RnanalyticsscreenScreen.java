package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth249RnanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 249;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-btn-1')]")
	private WebElement rnanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-screen')]")
	private WebElement rnanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-btn-4')]")
	private WebElement rnanalyticsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-btn-2')]")
	private WebElement rnanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-content')]")
	private WebElement rnanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-btn-3')]")
	private WebElement rnanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnanalytics-title')]")
	private WebElement rnanalyticsTitle;

    public Auth249RnanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth249RnanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth249RnanalyticsscreenScreen", "/offices/clinical/roles/rn/rn-analytics");
    }
}

