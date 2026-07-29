package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic838GovernancehudscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 838;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_hud-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_hud-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_hud-content')]")
	private WebElement primaryContent;

    public Clinic838GovernancehudscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic838GovernancehudscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic838GovernancehudscreenScreen", "/governance/hud");
    }
}

