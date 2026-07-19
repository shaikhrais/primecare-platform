package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic779TrainingdirectorstafftrainingmatrixscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 779;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_staff_training_matrix-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_staff_training_matrix-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_staff_training_matrix-content')]")
	private WebElement primaryContent;

    public Clinic779TrainingdirectorstafftrainingmatrixscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic779TrainingdirectorstafftrainingmatrixscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic779TrainingdirectorstafftrainingmatrixscreenScreen", "/offices/corporate/roles/training_director/staff-training-matrix");
    }
}
