package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic707PswmyclientsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 707;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_my_clients-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_my_clients-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_my_clients-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientlist-view')]")
	private WebElement clientlistView;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyclients-content')]")
	private WebElement pswmyclientsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientsearch-bar')]")
	private WebElement clientsearchBar;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientactivity-log')]")
	private WebElement clientactivityLog;

    public Clinic707PswmyclientsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic707PswmyclientsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic707PswmyclientsscreenScreen", "/generated/psw-my-clients");
    }
}

