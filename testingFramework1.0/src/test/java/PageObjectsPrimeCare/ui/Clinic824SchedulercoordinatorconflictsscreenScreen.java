package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic824SchedulercoordinatorconflictsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 824;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_conflicts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_conflicts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_conflicts-content')]")
	private WebElement primaryContent;

    public Clinic824SchedulercoordinatorconflictsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic824SchedulercoordinatorconflictsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic824SchedulercoordinatorconflictsscreenScreen", "/offices/franchise/roles/scheduler_coordinator/conflicts");
    }
}
