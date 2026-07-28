package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic790TraininganalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 790;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_analytics-content')]")
	private WebElement primaryContent;

    public Clinic790TraininganalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic790TraininganalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic790TraininganalyticsscreenScreen", "/generated/training-analytics");
    }
}

