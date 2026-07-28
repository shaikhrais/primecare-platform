package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic706PswmessagingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 706;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_messaging-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_messaging-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_messaging-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-messaging-btn-refresh')]")
	private WebElement pswMessagingBtnRefresh;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessaging-list')]")
	private WebElement pswmessagingList;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw-messaging-btn-send')]")
	private WebElement pswMessagingBtnSend;

    public Clinic706PswmessagingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic706PswmessagingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic706PswmessagingscreenScreen", "/generated/psw-messaging");
    }
}

