package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth214HeadofmarketinganalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 214;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketinganalytics-content')]")
	private WebElement headofmarketinganalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketinganalytics-screen')]")
	private WebElement headofmarketinganalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketinganalytics-btn-2')]")
	private WebElement headofmarketinganalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketinganalytics-title')]")
	private WebElement headofmarketinganalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketinganalytics-btn-1')]")
	private WebElement headofmarketinganalyticsBtn1;

    public Auth214HeadofmarketinganalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth214HeadofmarketinganalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth214HeadofmarketinganalyticsscreenScreen", "/management/head-of-marketing-analytics");
    }
}

