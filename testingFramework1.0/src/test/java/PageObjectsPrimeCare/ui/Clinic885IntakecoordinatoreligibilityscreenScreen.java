package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic885IntakecoordinatoreligibilityscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 885;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_eligibility-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_eligibility-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_eligibility-content')]")
	private WebElement primaryContent;

    public Clinic885IntakecoordinatoreligibilityscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic885IntakecoordinatoreligibilityscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic885IntakecoordinatoreligibilityscreenScreen", "/generated/intake-coordinator-eligibility");
    }
}
