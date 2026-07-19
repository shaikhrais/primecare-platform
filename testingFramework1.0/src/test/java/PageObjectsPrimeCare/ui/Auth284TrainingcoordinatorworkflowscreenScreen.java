package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth284TrainingcoordinatorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 284;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorworkflow-btn-1')]")
	private WebElement trainingcoordinatorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorworkflow-screen')]")
	private WebElement trainingcoordinatorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorworkflow-btn-3')]")
	private WebElement trainingcoordinatorworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorworkflow-title')]")
	private WebElement trainingcoordinatorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorworkflow-content')]")
	private WebElement trainingcoordinatorworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorworkflow-btn-2')]")
	private WebElement trainingcoordinatorworkflowBtn2;

    public Auth284TrainingcoordinatorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth284TrainingcoordinatorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth284TrainingcoordinatorworkflowscreenScreen", "/staff/training-coordinator-workflow");
    }
}
