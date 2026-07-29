package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth207GeneralmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 207;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerworkflow-screen')]")
	private WebElement generalmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerworkflow-content')]")
	private WebElement generalmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerworkflow-btn-1')]")
	private WebElement generalmanagerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerworkflow-btn-2')]")
	private WebElement generalmanagerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerworkflow-btn-3')]")
	private WebElement generalmanagerworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerworkflow-title')]")
	private WebElement generalmanagerworkflowTitle;

    public Auth207GeneralmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth207GeneralmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth207GeneralmanagerworkflowscreenScreen", "/management/general-manager-workflow");
    }
}

