package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic821SchedulercoordinatorappointmentcalendarscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 821;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_appointment_calendar-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_appointment_calendar-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_appointment_calendar-content')]")
	private WebElement primaryContent;

    public Clinic821SchedulercoordinatorappointmentcalendarscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic821SchedulercoordinatorappointmentcalendarscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic821SchedulercoordinatorappointmentcalendarscreenScreen", "/offices/franchise/roles/scheduler_coordinator/appointment-calendar");
    }
}
