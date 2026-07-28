package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic822SchedulercoordinatorassignmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 822;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_assignments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_assignments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_assignments-content')]")
	private WebElement primaryContent;

    public Clinic822SchedulercoordinatorassignmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic822SchedulercoordinatorassignmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic822SchedulercoordinatorassignmentsscreenScreen", "/offices/franchise/roles/scheduler_coordinator/assignments");
    }
}

