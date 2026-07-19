package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic350PhysiotherapistexerciseplanscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 350;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_exercise_plan-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_exercise_plan-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_exercise_plan-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistexerciseplan-screen')]")
	private WebElement physiotherapistexerciseplanScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistexerciseplan-content')]")
	private WebElement physiotherapistexerciseplanContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistexerciseplan-btn-2')]")
	private WebElement physiotherapistexerciseplanBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistexerciseplan-btn-1')]")
	private WebElement physiotherapistexerciseplanBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistexerciseplan-btn-3')]")
	private WebElement physiotherapistexerciseplanBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistexerciseplan-title')]")
	private WebElement physiotherapistexerciseplanTitle;

    public Clinic350PhysiotherapistexerciseplanscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic350PhysiotherapistexerciseplanscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic350PhysiotherapistexerciseplanscreenScreen", "/offices/clinical/roles/physiotherapist/exercise-plan");
    }
}
