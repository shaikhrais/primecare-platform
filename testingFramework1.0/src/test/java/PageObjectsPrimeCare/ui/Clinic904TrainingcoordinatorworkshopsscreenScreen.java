package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic904TrainingcoordinatorworkshopsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 904;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_workshops-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_workshops-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_workshops-content')]")
	private WebElement primaryContent;

    public Clinic904TrainingcoordinatorworkshopsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic904TrainingcoordinatorworkshopsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic904TrainingcoordinatorworkshopsscreenScreen", "/generated/training-coordinator-workshops");
    }
}
