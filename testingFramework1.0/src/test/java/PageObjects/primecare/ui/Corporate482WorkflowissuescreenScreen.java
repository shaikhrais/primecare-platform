package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate482WorkflowissuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 482;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflow_issue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflow_issue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflow_issue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-screen')]")
	private WebElement workflowissueScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-btn-2')]")
	private WebElement workflowissueBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-btn-1')]")
	private WebElement workflowissueBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-btn-3')]")
	private WebElement workflowissueBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-content')]")
	private WebElement workflowissueContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-loading')]")
	private WebElement workflowissueLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'workflowissue-title')]")
	private WebElement workflowissueTitle;

    public Corporate482WorkflowissuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate482WorkflowissuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate482WorkflowissuescreenScreen", "/executive/workflow-issue");
    }
}

