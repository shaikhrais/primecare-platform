package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic1022InformedconsenttrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1022;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'informed_consent_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'informed_consent_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'informed_consent_tracker-content')]")
	private WebElement primaryContent;

    public Clinic1022InformedconsenttrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic1022InformedconsenttrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic1022InformedconsenttrackerscreenScreen", "/generated/informed-consent-tracker");
    }
}
