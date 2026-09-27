package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic776TrainingdirectorcourselibraryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 776;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_course_library-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_course_library-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_course_library-content')]")
	private WebElement primaryContent;

    public Clinic776TrainingdirectorcourselibraryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic776TrainingdirectorcourselibraryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic776TrainingdirectorcourselibraryscreenScreen", "/offices/corporate/roles/training_director/course-library");
    }
}

