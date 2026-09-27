package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth254RpnanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 254;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_analytics_screen_textfield_input_1')]")
	private WebElement rpnAnalyticsScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-btn-1')]")
	private WebElement rpnanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-btn-4')]")
	private WebElement rpnanalyticsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-screen')]")
	private WebElement rpnanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-btn-2')]")
	private WebElement rpnanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-title')]")
	private WebElement rpnanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-content')]")
	private WebElement rpnanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnanalytics-btn-3')]")
	private WebElement rpnanalyticsBtn3;

    public Auth254RpnanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth254RpnanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth254RpnanalyticsscreenScreen", "/offices/clinical/roles/rpn/rpn-analytics");
    }
}

