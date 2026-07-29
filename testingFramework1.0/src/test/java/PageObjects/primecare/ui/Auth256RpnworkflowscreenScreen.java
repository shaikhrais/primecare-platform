package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth256RpnworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 256;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow_screen_textfield_input_1')]")
	private WebElement rpnWorkflowScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow_screen_textfield_input_2')]")
	private WebElement rpnWorkflowScreenTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-btn-2')]")
	private WebElement rpnworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-content')]")
	private WebElement rpnworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-loading')]")
	private WebElement rpnworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow_screen_textfield_input_5')]")
	private WebElement rpnWorkflowScreenTextfieldInput5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-btn-3')]")
	private WebElement rpnworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow_screen_textfield_input_4')]")
	private WebElement rpnWorkflowScreenTextfieldInput4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-title')]")
	private WebElement rpnworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-btn-1')]")
	private WebElement rpnworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpnworkflow-screen')]")
	private WebElement rpnworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_workflow_screen_textfield_input_3')]")
	private WebElement rpnWorkflowScreenTextfieldInput3;

    public Auth256RpnworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth256RpnworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth256RpnworkflowscreenScreen", "/offices/clinical/roles/rpn/rpn-workflow");
    }
}

