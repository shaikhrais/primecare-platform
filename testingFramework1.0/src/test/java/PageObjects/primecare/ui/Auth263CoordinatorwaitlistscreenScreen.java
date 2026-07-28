package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth263CoordinatorwaitlistscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 263;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_waitlist-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_waitlist-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_waitlist-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-screen')]")
	private WebElement coordinatorwaitlistScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-btn-4')]")
	private WebElement coordinatorwaitlistBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-btn-1')]")
	private WebElement coordinatorwaitlistBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-btn-5')]")
	private WebElement coordinatorwaitlistBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-title')]")
	private WebElement coordinatorwaitlistTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-btn-2')]")
	private WebElement coordinatorwaitlistBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-btn-3')]")
	private WebElement coordinatorwaitlistBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-content')]")
	private WebElement coordinatorwaitlistContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorwaitlist-loading')]")
	private WebElement coordinatorwaitlistLoading;

    public Auth263CoordinatorwaitlistscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth263CoordinatorwaitlistscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth263CoordinatorwaitlistscreenScreen", "/staff/coordinator-waitlist");
    }
}

