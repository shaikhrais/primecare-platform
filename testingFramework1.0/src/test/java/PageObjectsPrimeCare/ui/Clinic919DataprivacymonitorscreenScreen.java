package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic919DataprivacymonitorscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 919;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data_privacy_monitor-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data_privacy_monitor-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data_privacy_monitor-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data_privacy_monitor_iconbutton_button_1')]")
	private WebElement dataPrivacyMonitorIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data_privacy_monitor_outlinedbutton_button_1')]")
	private WebElement dataPrivacyMonitorOutlinedbuttonButton1;

    public Clinic919DataprivacymonitorscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic919DataprivacymonitorscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic919DataprivacymonitorscreenScreen", "/generated/data-privacy-monitor");
    }
}
