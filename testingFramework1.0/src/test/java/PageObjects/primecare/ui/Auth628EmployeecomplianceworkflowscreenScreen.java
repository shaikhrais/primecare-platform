package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth628EmployeecomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 628;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee compliance workflow-screen')]")
	private WebElement employeecomplianceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee compliance workflow-btn-2')]")
	private WebElement employeecomplianceworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee compliance workflow-btn-1')]")
	private WebElement employeecomplianceworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee compliance workflow-content')]")
	private WebElement employeecomplianceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee compliance workflow-btn-3')]")
	private WebElement employeecomplianceworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee compliance workflow-title')]")
	private WebElement employeecomplianceworkflowTitle;

    public Auth628EmployeecomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth628EmployeecomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth628EmployeecomplianceworkflowscreenScreen", "/staff/employee-workflow");
    }
}

