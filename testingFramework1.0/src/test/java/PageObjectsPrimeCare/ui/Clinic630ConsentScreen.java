package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic630ConsentScreen extends baseTest {
 
    public static final int SCREEN_ID = 630;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'consent-content')]")
	private WebElement primaryContent;

    public Clinic630ConsentScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic630ConsentScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic630ConsentScreen", "/generated/consent");
    }
}
