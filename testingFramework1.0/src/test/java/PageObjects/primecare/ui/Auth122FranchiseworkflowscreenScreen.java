package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth122FranchiseworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 122;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseworkflow-screen')]")
	private WebElement franchiseworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseworkflow-title')]")
	private WebElement franchiseworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseworkflow-btn-1')]")
	private WebElement franchiseworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseworkflow-content')]")
	private WebElement franchiseworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseworkflow-btn-2')]")
	private WebElement franchiseworkflowBtn2;

    public Auth122FranchiseworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth122FranchiseworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth122FranchiseworkflowscreenScreen", "/common/franchise-workflow");
    }
}

