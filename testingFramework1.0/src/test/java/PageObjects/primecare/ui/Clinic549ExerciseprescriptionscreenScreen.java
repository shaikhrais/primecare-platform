package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic549ExerciseprescriptionscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 549;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exercise_prescription-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exercise_prescription-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exercise_prescription-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exerciseprescription-title')]")
	private WebElement exerciseprescriptionTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exerciseprescription-btn-1')]")
	private WebElement exerciseprescriptionBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exerciseprescription-content')]")
	private WebElement exerciseprescriptionContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exerciseprescription-screen')]")
	private WebElement exerciseprescriptionScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exerciseprescription-btn-3')]")
	private WebElement exerciseprescriptionBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'exerciseprescription-btn-2')]")
	private WebElement exerciseprescriptionBtn2;

    public Clinic549ExerciseprescriptionscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic549ExerciseprescriptionscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic549ExerciseprescriptionscreenScreen", "/offices/clinical/roles/physiotherapist/exercise-prescription");
    }
}

