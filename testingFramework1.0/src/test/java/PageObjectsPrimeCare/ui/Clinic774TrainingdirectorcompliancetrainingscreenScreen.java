package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic774TrainingdirectorcompliancetrainingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 774;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_compliance_training-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_compliance_training-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_compliance_training-content')]")
	private WebElement primaryContent;

    public Clinic774TrainingdirectorcompliancetrainingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic774TrainingdirectorcompliancetrainingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic774TrainingdirectorcompliancetrainingscreenScreen", "/offices/corporate/roles/training_director/compliance-training");
    }
}
