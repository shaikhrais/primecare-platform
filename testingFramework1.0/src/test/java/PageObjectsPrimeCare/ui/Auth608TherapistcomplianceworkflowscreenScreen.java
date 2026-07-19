package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth608TherapistcomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 608;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist compliance workflow-btn-2')]")
	private WebElement therapistcomplianceworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist compliance workflow-screen')]")
	private WebElement therapistcomplianceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist compliance workflow-btn-3')]")
	private WebElement therapistcomplianceworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist compliance workflow-btn-1')]")
	private WebElement therapistcomplianceworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist compliance workflow-title')]")
	private WebElement therapistcomplianceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist compliance workflow-content')]")
	private WebElement therapistcomplianceworkflowContent;

    public Auth608TherapistcomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth608TherapistcomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth608TherapistcomplianceworkflowscreenScreen", "/offices/clinical/roles/therapist/workflow");
    }
}
