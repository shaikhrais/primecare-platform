package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate78HrmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 78;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-btn-2')]")
	private WebElement hrmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-screen')]")
	private WebElement hrmanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-content')]")
	private WebElement hrmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-btn-4')]")
	private WebElement hrmanagerdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-title')]")
	private WebElement hrmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-btn-1')]")
	private WebElement hrmanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-btn-3')]")
	private WebElement hrmanagerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanagerdashboard-btn-5')]")
	private WebElement hrmanagerdashboardBtn5;

    public Corporate78HrmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate78HrmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate78HrmanagerdashboardscreenScreen", "/offices/corporate/roles/hr_manager/dashboard");
    }
}

