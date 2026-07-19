package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic901TrainingcoordinatorprogressscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 901;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_progress-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_progress-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_progress-content')]")
	private WebElement primaryContent;

    public Clinic901TrainingcoordinatorprogressscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic901TrainingcoordinatorprogressscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic901TrainingcoordinatorprogressscreenScreen", "/generated/training-coordinator-progress");
    }
}
