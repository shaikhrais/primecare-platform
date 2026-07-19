package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic773TrainingdirectorcertificationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 773;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_certifications-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_certifications-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_certifications-content')]")
	private WebElement primaryContent;

    public Clinic773TrainingdirectorcertificationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic773TrainingdirectorcertificationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic773TrainingdirectorcertificationsscreenScreen", "/offices/corporate/roles/training_director/certifications");
    }
}
