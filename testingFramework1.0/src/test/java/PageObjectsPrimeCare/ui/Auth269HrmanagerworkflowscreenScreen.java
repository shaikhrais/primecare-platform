package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth269HrmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 269;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerworkflow-btn-2')]")
	private WebElement hrmanagerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerworkflow-content')]")
	private WebElement hrmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerworkflow-screen')]")
	private WebElement hrmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerworkflow-title')]")
	private WebElement hrmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerworkflow-btn-3')]")
	private WebElement hrmanagerworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerworkflow-btn-1')]")
	private WebElement hrmanagerworkflowBtn1;

    public Auth269HrmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth269HrmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth269HrmanagerworkflowscreenScreen", "/staff/hr-manager-workflow");
    }
}
