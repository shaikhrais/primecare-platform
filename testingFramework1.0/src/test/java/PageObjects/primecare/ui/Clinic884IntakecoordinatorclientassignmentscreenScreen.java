package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic884IntakecoordinatorclientassignmentscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 884;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_client_assignment-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_client_assignment-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_client_assignment-content')]")
	private WebElement primaryContent;

    public Clinic884IntakecoordinatorclientassignmentscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic884IntakecoordinatorclientassignmentscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic884IntakecoordinatorclientassignmentscreenScreen", "/generated/intake-coordinator-client-assignment");
    }
}

