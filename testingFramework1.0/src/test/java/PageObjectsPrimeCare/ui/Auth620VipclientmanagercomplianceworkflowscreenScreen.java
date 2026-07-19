package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth620VipclientmanagercomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 620;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager compliance workflow-title')]")
	private WebElement vipclientmanagercomplianceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager compliance workflow-screen')]")
	private WebElement vipclientmanagercomplianceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager compliance workflow-content')]")
	private WebElement vipclientmanagercomplianceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager compliance workflow-btn-1')]")
	private WebElement vipclientmanagercomplianceworkflowBtn1;

    public Auth620VipclientmanagercomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth620VipclientmanagercomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth620VipclientmanagercomplianceworkflowscreenScreen", "/executive/vip-manager-workflow");
    }
}
