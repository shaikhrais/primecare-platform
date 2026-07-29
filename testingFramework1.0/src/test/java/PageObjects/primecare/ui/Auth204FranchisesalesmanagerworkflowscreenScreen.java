package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth204FranchisesalesmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 204;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerworkflow-btn-2')]")
	private WebElement franchisesalesmanagerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerworkflow-title')]")
	private WebElement franchisesalesmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerworkflow-screen')]")
	private WebElement franchisesalesmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerworkflow-content')]")
	private WebElement franchisesalesmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerworkflow-btn-1')]")
	private WebElement franchisesalesmanagerworkflowBtn1;

    public Auth204FranchisesalesmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth204FranchisesalesmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth204FranchisesalesmanagerworkflowscreenScreen", "/management/franchise-sales-manager-workflow");
    }
}

