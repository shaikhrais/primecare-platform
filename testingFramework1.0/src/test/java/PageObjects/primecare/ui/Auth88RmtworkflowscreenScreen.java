package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth88RmtworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 88;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtworkflow-btn-1')]")
	private WebElement rmtworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtworkflow-btn-2')]")
	private WebElement rmtworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtworkflow-title')]")
	private WebElement rmtworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtworkflow-content')]")
	private WebElement rmtworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtworkflow-screen')]")
	private WebElement rmtworkflowScreen;

    public Auth88RmtworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth88RmtworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth88RmtworkflowscreenScreen", "/offices/clinical/roles/rmt/workflow");
    }
}

