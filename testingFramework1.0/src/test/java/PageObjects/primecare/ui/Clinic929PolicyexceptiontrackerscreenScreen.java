package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic929PolicyexceptiontrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 929;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_exception_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_exception_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_exception_tracker-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_exception_tracker_outlinedbutton_button_1')]")
	private WebElement policyExceptionTrackerOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_exception_tracker_iconbutton_button_1')]")
	private WebElement policyExceptionTrackerIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_exception_tracker_elevatedbutton_button_1')]")
	private WebElement policyExceptionTrackerElevatedbuttonButton1;

    public Clinic929PolicyexceptiontrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic929PolicyexceptiontrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic929PolicyexceptiontrackerscreenScreen", "/generated/policy-exception-tracker");
    }
}

