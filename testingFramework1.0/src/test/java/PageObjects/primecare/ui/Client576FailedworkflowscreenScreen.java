package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client576FailedworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 576;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failed_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failed_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failed_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-btn-4')]")
	private WebElement failedworkflowBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-btn-1')]")
	private WebElement failedworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-content')]")
	private WebElement failedworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-btn-5')]")
	private WebElement failedworkflowBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-screen')]")
	private WebElement failedworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-loading')]")
	private WebElement failedworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-btn-2')]")
	private WebElement failedworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-btn-3')]")
	private WebElement failedworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'failedworkflow-title')]")
	private WebElement failedworkflowTitle;

    public Client576FailedworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client576FailedworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client576FailedworkflowscreenScreen", "/staff/failed-workflow");
    }
}

