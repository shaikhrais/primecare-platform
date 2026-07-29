package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth192ShareholderworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 192;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderworkflow-content')]")
	private WebElement shareholderworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderworkflow-btn-3')]")
	private WebElement shareholderworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderworkflow-btn-1')]")
	private WebElement shareholderworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderworkflow-btn-2')]")
	private WebElement shareholderworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderworkflow-screen')]")
	private WebElement shareholderworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderworkflow-title')]")
	private WebElement shareholderworkflowTitle;

    public Auth192ShareholderworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth192ShareholderworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth192ShareholderworkflowscreenScreen", "/executive/shareholder-workflow");
    }
}

