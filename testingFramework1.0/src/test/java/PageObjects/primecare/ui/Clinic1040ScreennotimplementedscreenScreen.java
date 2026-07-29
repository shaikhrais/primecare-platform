package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1040ScreennotimplementedscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1040;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_not_implemented-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_not_implemented-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_not_implemented-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screennotimplemented-title')]")
	private WebElement screennotimplementedTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sharedstubs-btn-trigger-scan')]")
	private WebElement sharedstubsBtnTriggerScan;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sharedstubs-btn-manual-refresh')]")
	private WebElement sharedstubsBtnManualRefresh;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'sharedstubs-content')]")
	private WebElement sharedstubsContent;

    public Clinic1040ScreennotimplementedscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1040ScreennotimplementedscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1040ScreennotimplementedscreenScreen", "/generated/screen-not-implemented");
    }
}

