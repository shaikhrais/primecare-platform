package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic900TrainingcoordinatormaterialsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 900;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_materials-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_materials-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_materials-content')]")
	private WebElement primaryContent;

    public Clinic900TrainingcoordinatormaterialsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic900TrainingcoordinatormaterialsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic900TrainingcoordinatormaterialsscreenScreen", "/generated/training-coordinator-materials");
    }
}

