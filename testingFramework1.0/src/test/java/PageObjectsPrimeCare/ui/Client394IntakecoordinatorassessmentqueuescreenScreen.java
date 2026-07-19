package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client394IntakecoordinatorassessmentqueuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 394;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_assessment_queue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_assessment_queue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_assessment_queue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorassessmentqueue-screen')]")
	private WebElement intakecoordinatorassessmentqueueScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorassessmentqueue-btn-2')]")
	private WebElement intakecoordinatorassessmentqueueBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorassessmentqueue-title')]")
	private WebElement intakecoordinatorassessmentqueueTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorassessmentqueue-btn-1')]")
	private WebElement intakecoordinatorassessmentqueueBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatorassessmentqueue-content')]")
	private WebElement intakecoordinatorassessmentqueueContent;

    public Client394IntakecoordinatorassessmentqueuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client394IntakecoordinatorassessmentqueuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client394IntakecoordinatorassessmentqueuescreenScreen", "/executive/intake-coordinator-assessment-queue");
    }
}
