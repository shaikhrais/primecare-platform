package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic305ChiropractorexerciseplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 305;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_exercise_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_exercise_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_exercise_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorexerciseplan-screen')]")
	private WebElement chiropractorexerciseplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorexerciseplan-content')]")
	private WebElement chiropractorexerciseplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorexerciseplan-btn-3')]")
	private WebElement chiropractorexerciseplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorexerciseplan-btn-1')]")
	private WebElement chiropractorexerciseplanBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorexerciseplan-title')]")
	private WebElement chiropractorexerciseplanTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorexerciseplan-btn-2')]")
	private WebElement chiropractorexerciseplanBtn2;

    public Clinic305ChiropractorexerciseplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic305ChiropractorexerciseplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic305ChiropractorexerciseplanscreenScreen", "/offices/clinical/roles/chiropractor/exercise-plan");
    }
}
