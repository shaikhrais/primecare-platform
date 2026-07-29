package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth623NursepractitionernpanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 623;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) analytics-btn-1')]")
	private WebElement nursepractitionernpanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) analytics-content')]")
	private WebElement nursepractitionernpanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) analytics-screen')]")
	private WebElement nursepractitionernpanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) analytics-btn-2')]")
	private WebElement nursepractitionernpanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) analytics-title')]")
	private WebElement nursepractitionernpanalyticsTitle;

    public Auth623NursepractitionernpanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth623NursepractitionernpanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth623NursepractitionernpanalyticsscreenScreen", "/rn/np-analytics");
    }
}

