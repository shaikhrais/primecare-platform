package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic792TrainingprogramsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 792;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_programs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_programs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_programs-content')]")
	private WebElement primaryContent;

    public Clinic792TrainingprogramsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic792TrainingprogramsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic792TrainingprogramsscreenScreen", "/generated/training-programs");
    }
}

