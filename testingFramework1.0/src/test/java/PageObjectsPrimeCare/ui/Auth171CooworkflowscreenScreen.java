package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth171CooworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 171;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflow-btn-2')]")
	private WebElement cooworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflow-btn-1')]")
	private WebElement cooworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflow-screen')]")
	private WebElement cooworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflow-title')]")
	private WebElement cooworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflow-content')]")
	private WebElement cooworkflowContent;

    public Auth171CooworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth171CooworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth171CooworkflowscreenScreen", "/executive/coo-workflow");
    }
}
