package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth131IntakeworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 131;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeworkflow-btn-2')]")
	private WebElement intakeworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeworkflow-content')]")
	private WebElement intakeworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeworkflow-title')]")
	private WebElement intakeworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeworkflow-screen')]")
	private WebElement intakeworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakeworkflow-btn-1')]")
	private WebElement intakeworkflowBtn1;

    public Auth131IntakeworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth131IntakeworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth131IntakeworkflowscreenScreen", "/offices/clinical/roles/intake_coordinator/workflow");
    }
}

