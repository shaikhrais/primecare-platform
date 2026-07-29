package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth110CoursearchitectworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 110;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectworkflow-title')]")
	private WebElement coursearchitectworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectworkflow-content')]")
	private WebElement coursearchitectworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectworkflow-btn-1')]")
	private WebElement coursearchitectworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectworkflow-btn-2')]")
	private WebElement coursearchitectworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectworkflow-screen')]")
	private WebElement coursearchitectworkflowScreen;

    public Auth110CoursearchitectworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth110CoursearchitectworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth110CoursearchitectworkflowscreenScreen", "/common/course-architect-workflow");
    }
}

