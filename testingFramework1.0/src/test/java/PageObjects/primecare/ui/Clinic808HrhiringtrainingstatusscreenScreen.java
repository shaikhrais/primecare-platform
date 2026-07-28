package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic808HrhiringtrainingstatusscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 808;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_training_status-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_training_status-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_training_status-content')]")
	private WebElement primaryContent;

    public Clinic808HrhiringtrainingstatusscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic808HrhiringtrainingstatusscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic808HrhiringtrainingstatusscreenScreen", "/offices/franchise/roles/hr_hiring/training-status");
    }
}

