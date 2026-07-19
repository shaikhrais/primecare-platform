package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client501EmployeerecordsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 501;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_records-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_records-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employee_records-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-screen')]")
	private WebElement employeerecordsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-btn-3')]")
	private WebElement employeerecordsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-btn-1')]")
	private WebElement employeerecordsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-title')]")
	private WebElement employeerecordsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-loading')]")
	private WebElement employeerecordsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-content')]")
	private WebElement employeerecordsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'employeerecords-btn-2')]")
	private WebElement employeerecordsBtn2;

    public Client501EmployeerecordsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client501EmployeerecordsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client501EmployeerecordsscreenScreen", "/management/employee-records");
    }
}
