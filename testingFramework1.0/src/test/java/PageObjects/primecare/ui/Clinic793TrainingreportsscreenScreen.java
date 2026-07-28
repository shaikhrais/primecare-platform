package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic793TrainingreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 793;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_reports-content')]")
	private WebElement primaryContent;

    public Clinic793TrainingreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic793TrainingreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic793TrainingreportsscreenScreen", "/generated/training-reports");
    }
}

