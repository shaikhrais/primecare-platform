package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth174CtoworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 174;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoworkflow-content')]")
	private WebElement ctoworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoworkflow-btn-2')]")
	private WebElement ctoworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoworkflow-btn-1')]")
	private WebElement ctoworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoworkflow-title')]")
	private WebElement ctoworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoworkflow-screen')]")
	private WebElement ctoworkflowScreen;

    public Auth174CtoworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth174CtoworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth174CtoworkflowscreenScreen", "/executive/cto-workflow");
    }
}

