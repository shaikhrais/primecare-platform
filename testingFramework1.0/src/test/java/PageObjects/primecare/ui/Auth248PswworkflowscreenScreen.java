package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth248PswworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 248;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswworkflow-screen')]")
	private WebElement pswworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswworkflow-loading')]")
	private WebElement pswworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow_screen_textfield_input_4')]")
	private WebElement pswWorkflowScreenTextfieldInput4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswworkflow-content')]")
	private WebElement pswworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswworkflow-title')]")
	private WebElement pswworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow_screen_textfield_input_2')]")
	private WebElement pswWorkflowScreenTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow_screen_textfield_input_5')]")
	private WebElement pswWorkflowScreenTextfieldInput5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswworkflow-btn-2')]")
	private WebElement pswworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswworkflow-btn-1')]")
	private WebElement pswworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow_screen_textfield_input_1')]")
	private WebElement pswWorkflowScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_workflow_screen_textfield_input_3')]")
	private WebElement pswWorkflowScreenTextfieldInput3;

    public Auth248PswworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth248PswworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth248PswworkflowscreenScreen", "/offices/clinical/roles/psw/psw-workflow");
    }
}

