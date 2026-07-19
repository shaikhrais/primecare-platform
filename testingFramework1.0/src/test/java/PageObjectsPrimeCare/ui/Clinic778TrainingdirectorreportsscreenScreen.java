package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic778TrainingdirectorreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 778;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_reports-content')]")
	private WebElement primaryContent;

    public Clinic778TrainingdirectorreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic778TrainingdirectorreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic778TrainingdirectorreportsscreenScreen", "/offices/corporate/roles/training_director/reports");
    }
}
