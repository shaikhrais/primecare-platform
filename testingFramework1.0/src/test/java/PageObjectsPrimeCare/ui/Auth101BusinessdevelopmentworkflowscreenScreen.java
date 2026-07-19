package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth101BusinessdevelopmentworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 101;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentworkflow-screen')]")
	private WebElement businessdevelopmentworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentworkflow-title')]")
	private WebElement businessdevelopmentworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentworkflow-content')]")
	private WebElement businessdevelopmentworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentworkflow-btn-2')]")
	private WebElement businessdevelopmentworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentworkflow-btn-1')]")
	private WebElement businessdevelopmentworkflowBtn1;

    public Auth101BusinessdevelopmentworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth101BusinessdevelopmentworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth101BusinessdevelopmentworkflowscreenScreen", "/common/business-development-workflow");
    }
}
