package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic828SchedulercoordinatorshiftcalendarscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 828;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_shift_calendar-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_shift_calendar-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_shift_calendar-content')]")
	private WebElement primaryContent;

    public Clinic828SchedulercoordinatorshiftcalendarscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic828SchedulercoordinatorshiftcalendarscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic828SchedulercoordinatorshiftcalendarscreenScreen", "/offices/franchise/roles/scheduler_coordinator/shift-calendar");
    }
}
