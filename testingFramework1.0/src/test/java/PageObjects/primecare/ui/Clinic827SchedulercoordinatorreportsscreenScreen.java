package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic827SchedulercoordinatorreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 827;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_reports-content')]")
	private WebElement primaryContent;

    public Clinic827SchedulercoordinatorreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic827SchedulercoordinatorreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic827SchedulercoordinatorreportsscreenScreen", "/offices/franchise/roles/scheduler_coordinator/reports");
    }
}

