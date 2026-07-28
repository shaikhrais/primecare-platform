package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth226RegionalbdmanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 226;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmanalytics-btn-2')]")
	private WebElement regionalbdmanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmanalytics-btn-1')]")
	private WebElement regionalbdmanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmanalytics-title')]")
	private WebElement regionalbdmanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmanalytics-content')]")
	private WebElement regionalbdmanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmanalytics-screen')]")
	private WebElement regionalbdmanalyticsScreen;

    public Auth226RegionalbdmanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth226RegionalbdmanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth226RegionalbdmanalyticsscreenScreen", "/management/regional-bdm-analytics");
    }
}

