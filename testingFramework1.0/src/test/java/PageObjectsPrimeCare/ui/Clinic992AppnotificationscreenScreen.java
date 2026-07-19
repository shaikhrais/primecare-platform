package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic992AppnotificationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 992;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'app_notification-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'app_notification-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'app_notification-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'app_notification_screen_iconbutton_button_1')]")
	private WebElement appNotificationScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'app_notification_screen_textfield_input_1')]")
	private WebElement appNotificationScreenTextfieldInput1;

    public Clinic992AppnotificationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic992AppnotificationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic992AppnotificationscreenScreen", "/generated/app-notification");
    }
}
