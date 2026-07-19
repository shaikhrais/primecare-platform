package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic908PrimecarescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 908;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'prime_care-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'prime_care-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'prime_care-content')]")
	private WebElement primaryContent;

    public Clinic908PrimecarescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic908PrimecarescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic908PrimecarescreenScreen", "/generated/prime-care");
    }
}
