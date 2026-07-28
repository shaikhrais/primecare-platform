package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic777TrainingdirectorhubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 777;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_hub-content')]")
	private WebElement primaryContent;

    public Clinic777TrainingdirectorhubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic777TrainingdirectorhubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic777TrainingdirectorhubscreenScreen", "/offices/corporate/roles/training_director/hub");
    }
}

