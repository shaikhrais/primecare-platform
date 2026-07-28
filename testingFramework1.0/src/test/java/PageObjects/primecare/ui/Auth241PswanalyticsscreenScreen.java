package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth241PswanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 241;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-btn-3')]")
	private WebElement pswanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-content')]")
	private WebElement pswanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-btn-2')]")
	private WebElement pswanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-btn-1')]")
	private WebElement pswanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-btn-4')]")
	private WebElement pswanalyticsBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_analytics_screen_textfield_input_2')]")
	private WebElement pswAnalyticsScreenTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_analytics_screen_textfield_input_1')]")
	private WebElement pswAnalyticsScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-screen')]")
	private WebElement pswanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswanalytics-title')]")
	private WebElement pswanalyticsTitle;

    public Auth241PswanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth241PswanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth241PswanalyticsscreenScreen", "/offices/clinical/roles/psw/reports");
    }
}

