package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth281SchedulerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 281;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerworkflow-content')]")
	private WebElement schedulerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerworkflow-btn-2')]")
	private WebElement schedulerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerworkflow-btn-1')]")
	private WebElement schedulerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerworkflow-screen')]")
	private WebElement schedulerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerworkflow-title')]")
	private WebElement schedulerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerworkflow-btn-3')]")
	private WebElement schedulerworkflowBtn3;

    public Auth281SchedulerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth281SchedulerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth281SchedulerworkflowscreenScreen", "/staff/scheduler-workflow");
    }
}

