package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth177CxdirectorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 177;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorworkflow-btn-2')]")
	private WebElement cxdirectorworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorworkflow-title')]")
	private WebElement cxdirectorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorworkflow-btn-3')]")
	private WebElement cxdirectorworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorworkflow-btn-1')]")
	private WebElement cxdirectorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorworkflow-screen')]")
	private WebElement cxdirectorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectorworkflow-content')]")
	private WebElement cxdirectorworkflowContent;

    public Auth177CxdirectorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth177CxdirectorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth177CxdirectorworkflowscreenScreen", "/executive/cx-director-workflow");
    }
}

