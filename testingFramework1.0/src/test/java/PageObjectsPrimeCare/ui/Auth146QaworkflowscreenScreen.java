package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth146QaworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 146;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaworkflow-btn-1')]")
	private WebElement qaworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaworkflow-btn-2')]")
	private WebElement qaworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaworkflow-content')]")
	private WebElement qaworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaworkflow-title')]")
	private WebElement qaworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaworkflow-screen')]")
	private WebElement qaworkflowScreen;

    public Auth146QaworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth146QaworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth146QaworkflowscreenScreen", "/common/qa-workflow");
    }
}
