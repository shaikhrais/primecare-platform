package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth211HeadofbusdevanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 211;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevanalytics-title')]")
	private WebElement headofbusdevanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevanalytics-content')]")
	private WebElement headofbusdevanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevanalytics-btn-1')]")
	private WebElement headofbusdevanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevanalytics-btn-2')]")
	private WebElement headofbusdevanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevanalytics-screen')]")
	private WebElement headofbusdevanalyticsScreen;

    public Auth211HeadofbusdevanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth211HeadofbusdevanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth211HeadofbusdevanalyticsscreenScreen", "/management/head-of-bus-dev-analytics");
    }
}

