package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth272IntakecoordinatorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 272;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorworkflow-screen')]")
	private WebElement intakecoordinatorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorworkflow-btn-3')]")
	private WebElement intakecoordinatorworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorworkflow-title')]")
	private WebElement intakecoordinatorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorworkflow-content')]")
	private WebElement intakecoordinatorworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorworkflow-btn-2')]")
	private WebElement intakecoordinatorworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorworkflow-btn-1')]")
	private WebElement intakecoordinatorworkflowBtn1;

    public Auth272IntakecoordinatorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth272IntakecoordinatorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth272IntakecoordinatorworkflowscreenScreen", "/offices/clinical/roles/intake_coordinator/coordinator-workflow");
    }
}

