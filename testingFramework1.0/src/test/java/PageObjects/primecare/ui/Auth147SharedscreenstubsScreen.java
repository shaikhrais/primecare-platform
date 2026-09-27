package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth147SharedscreenstubsScreen extends baseTest {
 
    public static final int SCREEN_ID = 147;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shared_stubs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shared_stubs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shared_stubs-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screennotimplemented-title')]")
	private WebElement screennotimplementedTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sharedstubs-btn-trigger-scan')]")
	private WebElement sharedstubsBtnTriggerScan;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sharedstubs-btn-manual-refresh')]")
	private WebElement sharedstubsBtnManualRefresh;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sharedstubs-content')]")
	private WebElement sharedstubsContent;

    public Auth147SharedscreenstubsScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth147SharedscreenstubsScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth147SharedscreenstubsScreen", "/common/shared-stubs");
    }
}

