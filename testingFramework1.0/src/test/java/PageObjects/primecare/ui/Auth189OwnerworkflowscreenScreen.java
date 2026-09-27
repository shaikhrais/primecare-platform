package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth189OwnerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 189;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerworkflow-btn-2')]")
	private WebElement ownerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerworkflow-btn-1')]")
	private WebElement ownerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerworkflow-content')]")
	private WebElement ownerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerworkflow-title')]")
	private WebElement ownerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerworkflow-screen')]")
	private WebElement ownerworkflowScreen;

    public Auth189OwnerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth189OwnerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth189OwnerworkflowscreenScreen", "/executive/owner-workflow");
    }
}

