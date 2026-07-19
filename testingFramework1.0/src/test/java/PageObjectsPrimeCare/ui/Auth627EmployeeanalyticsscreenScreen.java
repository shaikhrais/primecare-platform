package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth627EmployeeanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 627;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-btn-2')]")
	private WebElement employeeanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-btn-1')]")
	private WebElement employeeanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-btn-3')]")
	private WebElement employeeanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-content')]")
	private WebElement employeeanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-title')]")
	private WebElement employeeanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-loading')]")
	private WebElement employeeanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee analytics-screen')]")
	private WebElement employeeanalyticsScreen;

    public Auth627EmployeeanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth627EmployeeanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth627EmployeeanalyticsscreenScreen", "/staff/employee-analytics");
    }
}
