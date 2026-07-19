package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth276ReceptionistanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 276;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistanalytics-screen')]")
	private WebElement receptionistanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistanalytics-title')]")
	private WebElement receptionistanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistanalytics-content')]")
	private WebElement receptionistanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistanalytics-btn-3')]")
	private WebElement receptionistanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistanalytics-btn-1')]")
	private WebElement receptionistanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistanalytics-btn-2')]")
	private WebElement receptionistanalyticsBtn2;

    public Auth276ReceptionistanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth276ReceptionistanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth276ReceptionistanalyticsscreenScreen", "/staff/receptionist-analytics");
    }
}
