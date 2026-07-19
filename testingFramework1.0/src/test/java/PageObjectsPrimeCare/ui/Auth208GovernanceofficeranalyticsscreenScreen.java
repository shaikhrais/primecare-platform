package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth208GovernanceofficeranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 208;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficeranalytics-screen')]")
	private WebElement governanceofficeranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficeranalytics-btn-1')]")
	private WebElement governanceofficeranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficeranalytics-title')]")
	private WebElement governanceofficeranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficeranalytics-btn-2')]")
	private WebElement governanceofficeranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficeranalytics-content')]")
	private WebElement governanceofficeranalyticsContent;

    public Auth208GovernanceofficeranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth208GovernanceofficeranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth208GovernanceofficeranalyticsscreenScreen", "/management/governance-officer-analytics");
    }
}
