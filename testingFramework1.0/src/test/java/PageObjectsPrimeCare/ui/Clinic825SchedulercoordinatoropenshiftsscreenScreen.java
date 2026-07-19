package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic825SchedulercoordinatoropenshiftsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 825;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_open_shifts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_open_shifts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_open_shifts-content')]")
	private WebElement primaryContent;

    public Clinic825SchedulercoordinatoropenshiftsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic825SchedulercoordinatoropenshiftsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic825SchedulercoordinatoropenshiftsscreenScreen", "/offices/franchise/roles/scheduler_coordinator/open-shifts");
    }
}
