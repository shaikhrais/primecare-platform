package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client522SchedulingdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 522;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduling_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-btn-5')]")
	private WebElement schedulingdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-btn-2')]")
	private WebElement schedulingdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-btn-1')]")
	private WebElement schedulingdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-content')]")
	private WebElement schedulingdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-btn-3')]")
	private WebElement schedulingdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-screen')]")
	private WebElement schedulingdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-btn-4')]")
	private WebElement schedulingdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulingdashboard-title')]")
	private WebElement schedulingdashboardTitle;

    public Client522SchedulingdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client522SchedulingdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client522SchedulingdashboardscreenScreen", "/staff/scheduling-dashboard");
    }
}
