package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth162TraininghubworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 162;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubworkflow-title')]")
	private WebElement traininghubworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubworkflow-content')]")
	private WebElement traininghubworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubworkflow-btn-1')]")
	private WebElement traininghubworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubworkflow-screen')]")
	private WebElement traininghubworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubworkflow-btn-2')]")
	private WebElement traininghubworkflowBtn2;

    public Auth162TraininghubworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth162TraininghubworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth162TraininghubworkflowscreenScreen", "/common/training-hub-workflow");
    }
}

