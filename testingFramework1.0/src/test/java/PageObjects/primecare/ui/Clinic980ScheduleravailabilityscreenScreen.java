package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic980ScheduleravailabilityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 980;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_availability-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_availability-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_availability-content')]")
	private WebElement primaryContent;

    public Clinic980ScheduleravailabilityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic980ScheduleravailabilityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic980ScheduleravailabilityscreenScreen", "/generated/scheduler-availability");
    }
}

