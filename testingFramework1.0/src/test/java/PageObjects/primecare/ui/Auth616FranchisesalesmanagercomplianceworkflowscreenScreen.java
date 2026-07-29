package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth616FranchisesalesmanagercomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 616;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager compliance workflow-content')]")
	private WebElement franchisesalesmanagercomplianceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager compliance workflow-btn-1')]")
	private WebElement franchisesalesmanagercomplianceworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager compliance workflow-screen')]")
	private WebElement franchisesalesmanagercomplianceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager compliance workflow-title')]")
	private WebElement franchisesalesmanagercomplianceworkflowTitle;

    public Auth616FranchisesalesmanagercomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth616FranchisesalesmanagercomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth616FranchisesalesmanagercomplianceworkflowscreenScreen", "/executive/franchise-sales-workflow");
    }
}

