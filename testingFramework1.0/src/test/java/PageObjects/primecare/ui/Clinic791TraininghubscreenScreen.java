package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic791TraininghubscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 791;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub-content')]")
	private WebElement primaryContent;

    public Clinic791TraininghubscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic791TraininghubscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic791TraininghubscreenScreen", "/generated/training-hub");
    }
}

