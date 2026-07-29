package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth613PediatricspecialistanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 613;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist analytics-title')]")
	private WebElement pediatricspecialistanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist analytics-btn-3')]")
	private WebElement pediatricspecialistanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist analytics-content')]")
	private WebElement pediatricspecialistanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist analytics-btn-1')]")
	private WebElement pediatricspecialistanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist analytics-screen')]")
	private WebElement pediatricspecialistanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist analytics-btn-2')]")
	private WebElement pediatricspecialistanalyticsBtn2;

    public Auth613PediatricspecialistanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth613PediatricspecialistanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth613PediatricspecialistanalyticsscreenScreen", "/clinical/pediatric-analytics");
    }
}

