package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth159SystemworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 159;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemworkflow-btn-2')]")
	private WebElement systemworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemworkflow-title')]")
	private WebElement systemworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemworkflow-content')]")
	private WebElement systemworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemworkflow-btn-1')]")
	private WebElement systemworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemworkflow-screen')]")
	private WebElement systemworkflowScreen;

    public Auth159SystemworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth159SystemworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth159SystemworkflowscreenScreen", "/common/system-workflow");
    }
}

