package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth244MessagesScreen extends baseTest {
 
    public static final int SCREEN_ID = 244;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_messages-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_messages-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_messages-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-title')]")
	private WebElement pswmessagesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-btn-4')]")
	private WebElement pswmessagesBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-content')]")
	private WebElement pswmessagesContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-btn-1')]")
	private WebElement pswmessagesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-btn-2')]")
	private WebElement pswmessagesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-loading')]")
	private WebElement pswmessagesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-btn-3')]")
	private WebElement pswmessagesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmessages-screen')]")
	private WebElement pswmessagesScreen;

    public Auth244MessagesScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth244MessagesScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth244MessagesScreen", "/offices/clinical/roles/psw/messages");
    }
}

