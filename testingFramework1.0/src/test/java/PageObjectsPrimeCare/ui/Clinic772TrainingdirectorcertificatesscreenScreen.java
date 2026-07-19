package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic772TrainingdirectorcertificatesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 772;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_certificates-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_certificates-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_certificates-content')]")
	private WebElement primaryContent;

    public Clinic772TrainingdirectorcertificatesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic772TrainingdirectorcertificatesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic772TrainingdirectorcertificatesscreenScreen", "/offices/corporate/roles/training_director/certificates");
    }
}
