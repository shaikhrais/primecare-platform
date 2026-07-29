package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic889IntakecoordinatorschedulingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 889;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_scheduling-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_scheduling-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_scheduling-content')]")
	private WebElement primaryContent;

    public Clinic889IntakecoordinatorschedulingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic889IntakecoordinatorschedulingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic889IntakecoordinatorschedulingscreenScreen", "/generated/intake-coordinator-scheduling");
    }
}

