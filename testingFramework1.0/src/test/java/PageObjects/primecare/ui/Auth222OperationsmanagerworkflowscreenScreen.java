package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth222OperationsmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 222;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagerworkflow-content')]")
	private WebElement operationsmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagerworkflow-screen')]")
	private WebElement operationsmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagerworkflow-title')]")
	private WebElement operationsmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagerworkflow-btn-2')]")
	private WebElement operationsmanagerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanagerworkflow-btn-1')]")
	private WebElement operationsmanagerworkflowBtn1;

    public Auth222OperationsmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth222OperationsmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth222OperationsmanagerworkflowscreenScreen", "/management/operations-manager-workflow");
    }
}

