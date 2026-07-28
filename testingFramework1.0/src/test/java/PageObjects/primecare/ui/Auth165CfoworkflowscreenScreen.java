package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth165CfoworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 165;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoworkflow-screen')]")
	private WebElement cfoworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoworkflow-btn-2')]")
	private WebElement cfoworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoworkflow-title')]")
	private WebElement cfoworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoworkflow-btn-1')]")
	private WebElement cfoworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoworkflow-content')]")
	private WebElement cfoworkflowContent;

    public Auth165CfoworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth165CfoworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth165CfoworkflowscreenScreen", "/executive/cfo-workflow");
    }
}

