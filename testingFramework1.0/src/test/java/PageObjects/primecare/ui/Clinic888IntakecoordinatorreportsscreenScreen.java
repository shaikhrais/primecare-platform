package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic888IntakecoordinatorreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 888;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_reports-content')]")
	private WebElement primaryContent;

    public Clinic888IntakecoordinatorreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic888IntakecoordinatorreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic888IntakecoordinatorreportsscreenScreen", "/generated/intake-coordinator-reports");
    }
}

