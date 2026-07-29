package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic780TrainingdirectortrainerassignmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 780;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_trainer_assignments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_trainer_assignments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_trainer_assignments-content')]")
	private WebElement primaryContent;

    public Clinic780TrainingdirectortrainerassignmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic780TrainingdirectortrainerassignmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic780TrainingdirectortrainerassignmentsscreenScreen", "/offices/corporate/roles/training_director/trainer-assignments");
    }
}

