package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic775TrainingdirectorcoursearchitectscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 775;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_course_architect-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_course_architect-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_course_architect-content')]")
	private WebElement primaryContent;

    public Clinic775TrainingdirectorcoursearchitectscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic775TrainingdirectorcoursearchitectscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic775TrainingdirectorcoursearchitectscreenScreen", "/offices/corporate/roles/training_director/course-architect");
    }
}

