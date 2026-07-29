package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth98ArchitectureplanningworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 98;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningworkflow-title')]")
	private WebElement architectureplanningworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningworkflow-btn-1')]")
	private WebElement architectureplanningworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningworkflow-screen')]")
	private WebElement architectureplanningworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningworkflow-btn-2')]")
	private WebElement architectureplanningworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningworkflow-content')]")
	private WebElement architectureplanningworkflowContent;

    public Auth98ArchitectureplanningworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth98ArchitectureplanningworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth98ArchitectureplanningworkflowscreenScreen", "/common/architecture-planning-workflow");
    }
}

