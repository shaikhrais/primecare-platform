package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic899TrainingcoordinatorcoursesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 899;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_courses-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_courses-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_courses-content')]")
	private WebElement primaryContent;

    public Clinic899TrainingcoordinatorcoursesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic899TrainingcoordinatorcoursesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic899TrainingcoordinatorcoursesscreenScreen", "/generated/training-coordinator-courses");
    }
}
