package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth149SocialworkercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 149;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkercompliance-content')]")
	private WebElement socialworkercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkercompliance-screen')]")
	private WebElement socialworkercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkercompliance-title')]")
	private WebElement socialworkercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkercompliance-btn-3')]")
	private WebElement socialworkercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkercompliance-btn-2')]")
	private WebElement socialworkercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkercompliance-btn-1')]")
	private WebElement socialworkercomplianceBtn1;

    public Auth149SocialworkercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth149SocialworkercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth149SocialworkercompliancescreenScreen", "/offices/clinical/roles/social_worker/compliance");
    }
}

