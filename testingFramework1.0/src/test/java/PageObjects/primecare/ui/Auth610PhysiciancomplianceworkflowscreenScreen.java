package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth610PhysiciancomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 610;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician compliance workflow-title')]")
	private WebElement physiciancomplianceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician compliance workflow-screen')]")
	private WebElement physiciancomplianceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician compliance workflow-btn-2')]")
	private WebElement physiciancomplianceworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician compliance workflow-btn-3')]")
	private WebElement physiciancomplianceworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician compliance workflow-content')]")
	private WebElement physiciancomplianceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician compliance workflow-btn-1')]")
	private WebElement physiciancomplianceworkflowBtn1;

    public Auth610PhysiciancomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth610PhysiciancomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth610PhysiciancomplianceworkflowscreenScreen", "/clinical/physician-workflow");
    }
}

