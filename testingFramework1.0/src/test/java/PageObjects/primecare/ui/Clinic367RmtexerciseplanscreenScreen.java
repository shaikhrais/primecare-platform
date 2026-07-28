package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic367RmtexerciseplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 367;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_exercise_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_exercise_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_exercise_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-btn-3')]")
	private WebElement rmtexerciseplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-title')]")
	private WebElement rmtexerciseplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-content')]")
	private WebElement rmtexerciseplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-screen')]")
	private WebElement rmtexerciseplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-loading')]")
	private WebElement rmtexerciseplanLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-btn-2')]")
	private WebElement rmtexerciseplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtexerciseplan-btn-1')]")
	private WebElement rmtexerciseplanBtn1;

    public Clinic367RmtexerciseplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic367RmtexerciseplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic367RmtexerciseplanscreenScreen", "/offices/clinical/roles/rmt/exercise-plan");
    }
}

