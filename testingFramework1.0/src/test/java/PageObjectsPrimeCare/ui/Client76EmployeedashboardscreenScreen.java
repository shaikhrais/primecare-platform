package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client76EmployeedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 76;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-content')]")
	private WebElement employeedashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-btn-2')]")
	private WebElement employeedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-btn-1')]")
	private WebElement employeedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-loading')]")
	private WebElement employeedashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-btn-3')]")
	private WebElement employeedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-screen')]")
	private WebElement employeedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-title')]")
	private WebElement employeedashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-btn-4')]")
	private WebElement employeedashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeedashboard-btn-5')]")
	private WebElement employeedashboardBtn5;

    public Client76EmployeedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client76EmployeedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client76EmployeedashboardscreenScreen", "/staff/employee-dashboard");
    }
}
