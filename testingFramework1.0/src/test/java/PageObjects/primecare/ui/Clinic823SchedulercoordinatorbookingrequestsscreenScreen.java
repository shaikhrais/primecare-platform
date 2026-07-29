package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic823SchedulercoordinatorbookingrequestsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 823;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_booking_requests-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_booking_requests-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_booking_requests-content')]")
	private WebElement primaryContent;

    public Clinic823SchedulercoordinatorbookingrequestsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic823SchedulercoordinatorbookingrequestsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic823SchedulercoordinatorbookingrequestsscreenScreen", "/offices/franchise/roles/scheduler_coordinator/booking-requests");
    }
}

