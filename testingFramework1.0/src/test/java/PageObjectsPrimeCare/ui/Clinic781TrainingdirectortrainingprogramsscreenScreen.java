package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic781TrainingdirectortrainingprogramsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 781;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_training_programs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_training_programs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_training_programs-content')]")
	private WebElement primaryContent;

    public Clinic781TrainingdirectortrainingprogramsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic781TrainingdirectortrainingprogramsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic781TrainingdirectortrainingprogramsscreenScreen", "/offices/corporate/roles/training_director/training-programs");
    }
}
