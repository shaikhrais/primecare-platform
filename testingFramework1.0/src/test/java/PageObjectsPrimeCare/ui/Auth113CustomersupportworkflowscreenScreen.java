package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth113CustomersupportworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 113;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportworkflow-btn-1')]")
	private WebElement customersupportworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportworkflow-content')]")
	private WebElement customersupportworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportworkflow-title')]")
	private WebElement customersupportworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportworkflow-screen')]")
	private WebElement customersupportworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportworkflow-btn-2')]")
	private WebElement customersupportworkflowBtn2;

    public Auth113CustomersupportworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth113CustomersupportworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth113CustomersupportworkflowscreenScreen", "/common/customer-support-workflow");
    }
}
