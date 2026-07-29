package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth259BillingadminworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 259;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminworkflow-btn-2')]")
	private WebElement billingadminworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminworkflow-content')]")
	private WebElement billingadminworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminworkflow-title')]")
	private WebElement billingadminworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminworkflow-screen')]")
	private WebElement billingadminworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminworkflow-btn-3')]")
	private WebElement billingadminworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminworkflow-btn-1')]")
	private WebElement billingadminworkflowBtn1;

    public Auth259BillingadminworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth259BillingadminworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth259BillingadminworkflowscreenScreen", "/staff/billing-admin-workflow");
    }
}

