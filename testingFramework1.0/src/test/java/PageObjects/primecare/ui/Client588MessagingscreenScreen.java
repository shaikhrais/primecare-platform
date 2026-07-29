package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client588MessagingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 588;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-loading')]")
	private WebElement messagingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-btn-2')]")
	private WebElement messagingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-btn-1')]")
	private WebElement messagingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'messaging-btn-3')]")
	private WebElement messagingBtn3;

    public Client588MessagingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client588MessagingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client588MessagingscreenScreen", "/clinic/messaging");
    }
}

