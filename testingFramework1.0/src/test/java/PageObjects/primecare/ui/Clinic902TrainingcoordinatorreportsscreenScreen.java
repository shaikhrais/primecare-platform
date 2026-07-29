package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic902TrainingcoordinatorreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 902;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_reports-content')]")
	private WebElement primaryContent;

    public Clinic902TrainingcoordinatorreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic902TrainingcoordinatorreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic902TrainingcoordinatorreportsscreenScreen", "/generated/training-coordinator-reports");
    }
}

