package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth181HrdirectoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 181;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoranalytics-btn-1')]")
	private WebElement hrdirectoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoranalytics-btn-2')]")
	private WebElement hrdirectoranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoranalytics-title')]")
	private WebElement hrdirectoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoranalytics-content')]")
	private WebElement hrdirectoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoranalytics-screen')]")
	private WebElement hrdirectoranalyticsScreen;

    public Auth181HrdirectoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth181HrdirectoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth181HrdirectoranalyticsscreenScreen", "/executive/hr-director-analytics");
    }
}

