package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance600WorkflowexecutionscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 600;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflow_execution-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflow_execution-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflow_execution-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-loading')]")
	private WebElement workflowexecutionLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-title')]")
	private WebElement workflowexecutionTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-btn-2')]")
	private WebElement workflowexecutionBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-btn-1')]")
	private WebElement workflowexecutionBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-screen')]")
	private WebElement workflowexecutionScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-content')]")
	private WebElement workflowexecutionContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowexecution-btn-3')]")
	private WebElement workflowexecutionBtn3;

    public Governance600WorkflowexecutionscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance600WorkflowexecutionscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance600WorkflowexecutionscreenScreen", "/common/workflow-execution");
    }
}
