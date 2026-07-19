package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth125GuestworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 125;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-content')]")
	private WebElement guestworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-btn-3')]")
	private WebElement guestworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-btn-2')]")
	private WebElement guestworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-screen')]")
	private WebElement guestworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-loading')]")
	private WebElement guestworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-title')]")
	private WebElement guestworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestworkflow-btn-1')]")
	private WebElement guestworkflowBtn1;

    public Auth125GuestworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth125GuestworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth125GuestworkflowscreenScreen", "/common/guest-workflow");
    }
}
