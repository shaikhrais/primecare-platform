package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth150SocialworkerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 150;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerworkflow-btn-1')]")
	private WebElement socialworkerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerworkflow-screen')]")
	private WebElement socialworkerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerworkflow-btn-2')]")
	private WebElement socialworkerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerworkflow-content')]")
	private WebElement socialworkerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerworkflow-title')]")
	private WebElement socialworkerworkflowTitle;

    public Auth150SocialworkerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth150SocialworkerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth150SocialworkerworkflowscreenScreen", "/offices/clinical/roles/social_worker/workflow");
    }
}

