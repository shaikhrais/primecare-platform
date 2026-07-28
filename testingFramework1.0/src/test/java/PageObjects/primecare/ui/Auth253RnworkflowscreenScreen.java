package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth253RnworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 253;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_workflow_screen_textfield_input_2')]")
	private WebElement rnWorkflowScreenTextfieldInput2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnworkflow-screen')]")
	private WebElement rnworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnworkflow-loading')]")
	private WebElement rnworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_workflow_screen_textfield_input_1')]")
	private WebElement rnWorkflowScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnworkflow-btn-1')]")
	private WebElement rnworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_workflow_screen_textfield_input_3')]")
	private WebElement rnWorkflowScreenTextfieldInput3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnworkflow-title')]")
	private WebElement rnworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnworkflow-btn-2')]")
	private WebElement rnworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rnworkflow-content')]")
	private WebElement rnworkflowContent;

    public Auth253RnworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth253RnworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth253RnworkflowscreenScreen", "/offices/clinical/roles/rn/rn-workflow");
    }
}

