package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth264HrhiringanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 264;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringanalytics-content')]")
	private WebElement hrhiringanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringanalytics-btn-2')]")
	private WebElement hrhiringanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringanalytics-btn-1')]")
	private WebElement hrhiringanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringanalytics-screen')]")
	private WebElement hrhiringanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringanalytics-btn-3')]")
	private WebElement hrhiringanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringanalytics-title')]")
	private WebElement hrhiringanalyticsTitle;

    public Auth264HrhiringanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth264HrhiringanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth264HrhiringanalyticsscreenScreen", "/staff/hr-hiring-analytics");
    }
}

