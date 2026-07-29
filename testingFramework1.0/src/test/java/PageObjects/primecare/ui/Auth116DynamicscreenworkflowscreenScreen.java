package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth116DynamicscreenworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 116;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-btn-3')]")
	private WebElement dynamicworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-btn-1')]")
	private WebElement dynamicworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-loading')]")
	private WebElement dynamicworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-screen')]")
	private WebElement dynamicworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-content')]")
	private WebElement dynamicworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-title')]")
	private WebElement dynamicworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamicworkflow-btn-2')]")
	private WebElement dynamicworkflowBtn2;

    public Auth116DynamicscreenworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth116DynamicscreenworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth116DynamicscreenworkflowscreenScreen", "/common/dynamic-workflow");
    }
}

