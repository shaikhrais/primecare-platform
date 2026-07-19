package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic898TrainingcoordinatorcertificationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 898;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_certifications-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_certifications-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_certifications-content')]")
	private WebElement primaryContent;

    public Clinic898TrainingcoordinatorcertificationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic898TrainingcoordinatorcertificationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic898TrainingcoordinatorcertificationsscreenScreen", "/generated/training-coordinator-certifications");
    }
}
