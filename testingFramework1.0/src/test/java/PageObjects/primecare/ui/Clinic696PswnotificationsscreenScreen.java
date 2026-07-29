package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic696PswnotificationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 696;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_notifications-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_notifications-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_notifications-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_notifications-list')]")
	private WebElement pswNotificationsList;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_notifications-settings')]")
	private WebElement pswNotificationsSettings;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswnotifications-content')]")
	private WebElement pswnotificationsContent;

    public Clinic696PswnotificationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic696PswnotificationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic696PswnotificationsscreenScreen", "/generated/psw-notifications");
    }
}

