package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth618PremiumconciergecarecoordinatorcomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 618;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_workflow-content')]")
	private WebElement primaryContent;

    public Auth618PremiumconciergecarecoordinatorcomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth618PremiumconciergecarecoordinatorcomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth618PremiumconciergecarecoordinatorcomplianceworkflowscreenScreen", "/premium/premium-concierge-workflow");
    }
}

