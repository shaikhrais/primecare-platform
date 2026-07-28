package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth158SystemverificationworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 158;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationworkflow-content')]")
	private WebElement systemverificationworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationworkflow-screen')]")
	private WebElement systemverificationworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationworkflow-btn-1')]")
	private WebElement systemverificationworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationworkflow-btn-2')]")
	private WebElement systemverificationworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationworkflow-title')]")
	private WebElement systemverificationworkflowTitle;

    public Auth158SystemverificationworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth158SystemverificationworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth158SystemverificationworkflowscreenScreen", "/common/system-verification-workflow");
    }
}

