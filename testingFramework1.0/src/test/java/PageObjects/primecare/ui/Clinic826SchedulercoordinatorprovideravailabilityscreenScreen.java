package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic826SchedulercoordinatorprovideravailabilityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 826;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_provider_availability-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_provider_availability-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_coordinator_provider_availability-content')]")
	private WebElement primaryContent;

    public Clinic826SchedulercoordinatorprovideravailabilityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic826SchedulercoordinatorprovideravailabilityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic826SchedulercoordinatorprovideravailabilityscreenScreen", "/offices/franchise/roles/scheduler_coordinator/provider-availability");
    }
}

