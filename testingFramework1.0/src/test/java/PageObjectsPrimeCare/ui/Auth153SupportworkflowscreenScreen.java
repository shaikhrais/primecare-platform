package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth153SupportworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 153;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportworkflow-screen')]")
	private WebElement supportworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportworkflow-btn-1')]")
	private WebElement supportworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportworkflow-content')]")
	private WebElement supportworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportworkflow-btn-2')]")
	private WebElement supportworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportworkflow-title')]")
	private WebElement supportworkflowTitle;

    public Auth153SupportworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth153SupportworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth153SupportworkflowscreenScreen", "/common/support-workflow");
    }
}
