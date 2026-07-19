package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1012PublichealthalertbroadcasterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1012;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'public_health_alert_broadcaster-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'public_health_alert_broadcaster-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'public_health_alert_broadcaster-content')]")
	private WebElement primaryContent;

    public Clinic1012PublichealthalertbroadcasterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1012PublichealthalertbroadcasterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1012PublichealthalertbroadcasterscreenScreen", "/generated/public-health-alert-broadcaster");
    }
}
