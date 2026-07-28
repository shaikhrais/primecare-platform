package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth168CisoworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 168;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-btn-3')]")
	private WebElement cisoworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-screen')]")
	private WebElement cisoworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-content')]")
	private WebElement cisoworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-btn-2')]")
	private WebElement cisoworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-loading')]")
	private WebElement cisoworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-btn-1')]")
	private WebElement cisoworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoworkflow-title')]")
	private WebElement cisoworkflowTitle;

    public Auth168CisoworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth168CisoworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth168CisoworkflowscreenScreen", "/executive/ciso-workflow");
    }
}

