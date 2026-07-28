package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth143PortalworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 143;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-title')]")
	private WebElement portalworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-btn-1')]")
	private WebElement portalworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-btn-2')]")
	private WebElement portalworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-btn-3')]")
	private WebElement portalworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-screen')]")
	private WebElement portalworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-loading')]")
	private WebElement portalworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalworkflow-content')]")
	private WebElement portalworkflowContent;

    public Auth143PortalworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth143PortalworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth143PortalworkflowscreenScreen", "/common/portal-workflow");
    }
}

