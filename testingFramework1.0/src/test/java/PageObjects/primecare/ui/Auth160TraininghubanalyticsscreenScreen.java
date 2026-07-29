package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth160TraininghubanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 160;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubanalytics-btn-2')]")
	private WebElement traininghubanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubanalytics-content')]")
	private WebElement traininghubanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubanalytics-screen')]")
	private WebElement traininghubanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubanalytics-title')]")
	private WebElement traininghubanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubanalytics-btn-1')]")
	private WebElement traininghubanalyticsBtn1;

    public Auth160TraininghubanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth160TraininghubanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth160TraininghubanalyticsscreenScreen", "/common/training-hub-analytics");
    }
}

