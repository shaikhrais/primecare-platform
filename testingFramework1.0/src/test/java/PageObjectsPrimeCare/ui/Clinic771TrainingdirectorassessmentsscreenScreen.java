package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic771TrainingdirectorassessmentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 771;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_assessments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_assessments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_assessments-content')]")
	private WebElement primaryContent;

    public Clinic771TrainingdirectorassessmentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic771TrainingdirectorassessmentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic771TrainingdirectorassessmentsscreenScreen", "/offices/corporate/roles/training_director/assessments");
    }
}
