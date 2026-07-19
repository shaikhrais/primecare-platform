package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth138PhysiotherapistanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 138;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistanalytics-btn-1')]")
	private WebElement physiotherapistanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistanalytics-screen')]")
	private WebElement physiotherapistanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistanalytics-btn-2')]")
	private WebElement physiotherapistanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistanalytics-content')]")
	private WebElement physiotherapistanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistanalytics-title')]")
	private WebElement physiotherapistanalyticsTitle;

    public Auth138PhysiotherapistanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth138PhysiotherapistanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth138PhysiotherapistanalyticsscreenScreen", "/offices/clinical/roles/physiotherapist/analytics");
    }
}
