package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic886IntakecoordinatorintakeformsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 886;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_intake_forms-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_intake_forms-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_intake_forms-content')]")
	private WebElement primaryContent;

    public Clinic886IntakecoordinatorintakeformsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic886IntakecoordinatorintakeformsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic886IntakecoordinatorintakeformsscreenScreen", "/generated/intake-coordinator-intake-forms");
    }
}

