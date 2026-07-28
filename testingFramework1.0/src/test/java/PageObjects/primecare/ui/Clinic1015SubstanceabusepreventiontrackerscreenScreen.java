package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1015SubstanceabusepreventiontrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1015;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance_abuse_prevention_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance_abuse_prevention_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'substance_abuse_prevention_tracker-content')]")
	private WebElement primaryContent;

    public Clinic1015SubstanceabusepreventiontrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1015SubstanceabusepreventiontrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1015SubstanceabusepreventiontrackerscreenScreen", "/generated/substance-abuse-prevention-tracker");
    }
}

