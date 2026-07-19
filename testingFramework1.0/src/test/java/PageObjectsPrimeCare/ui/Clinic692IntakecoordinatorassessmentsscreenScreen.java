package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic692IntakecoordinatorassessmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 692;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_assessments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_assessments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_assessments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorassessmentsscreen-screen')]")
	private WebElement intakecoordinatorassessmentsscreenScreen;

    public Clinic692IntakecoordinatorassessmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic692IntakecoordinatorassessmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic692IntakecoordinatorassessmentsscreenScreen", "/generated/intake-coordinator-assessments");
    }
}
