package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth114DynamicscreenanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 114;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicanalytics-content')]")
	private WebElement dynamicanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicanalytics-title')]")
	private WebElement dynamicanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicanalytics-screen')]")
	private WebElement dynamicanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicanalytics-btn-2')]")
	private WebElement dynamicanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicanalytics-btn-1')]")
	private WebElement dynamicanalyticsBtn1;

    public Auth114DynamicscreenanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth114DynamicscreenanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth114DynamicscreenanalyticsscreenScreen", "/common/dynamic-analytics");
    }
}
