package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth261CoordinatorhubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 261;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinator_hub-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-4')]")
	private WebElement coordinatorhubBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-content')]")
	private WebElement coordinatorhubContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-6')]")
	private WebElement coordinatorhubBtn6;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-5')]")
	private WebElement coordinatorhubBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-loading')]")
	private WebElement coordinatorhubLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-title')]")
	private WebElement coordinatorhubTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-2')]")
	private WebElement coordinatorhubBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-7')]")
	private WebElement coordinatorhubBtn7;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-screen')]")
	private WebElement coordinatorhubScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-3')]")
	private WebElement coordinatorhubBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coordinatorhub-btn-1')]")
	private WebElement coordinatorhubBtn1;

    public Auth261CoordinatorhubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth261CoordinatorhubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth261CoordinatorhubscreenScreen", "/staff/coordinator-hub");
    }
}

