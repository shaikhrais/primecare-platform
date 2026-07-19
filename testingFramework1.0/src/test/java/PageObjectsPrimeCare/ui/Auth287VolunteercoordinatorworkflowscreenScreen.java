package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth287VolunteercoordinatorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 287;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_coordinator_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorworkflow-btn-3')]")
	private WebElement volunteercoordinatorworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorworkflow-btn-1')]")
	private WebElement volunteercoordinatorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorworkflow-screen')]")
	private WebElement volunteercoordinatorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorworkflow-btn-2')]")
	private WebElement volunteercoordinatorworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorworkflow-title')]")
	private WebElement volunteercoordinatorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteercoordinatorworkflow-content')]")
	private WebElement volunteercoordinatorworkflowContent;

    public Auth287VolunteercoordinatorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth287VolunteercoordinatorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth287VolunteercoordinatorworkflowscreenScreen", "/staff/volunteer-coordinator-workflow");
    }
}
