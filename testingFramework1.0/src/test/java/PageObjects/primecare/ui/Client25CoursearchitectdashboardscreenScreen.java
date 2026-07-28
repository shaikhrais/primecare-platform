package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client25CoursearchitectdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 25;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'course_architect_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectdashboard-btn-2')]")
	private WebElement coursearchitectdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectdashboard-title')]")
	private WebElement coursearchitectdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectdashboard-screen')]")
	private WebElement coursearchitectdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectdashboard-btn-1')]")
	private WebElement coursearchitectdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectdashboard-btn-3')]")
	private WebElement coursearchitectdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coursearchitectdashboard-content')]")
	private WebElement coursearchitectdashboardContent;

    public Client25CoursearchitectdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client25CoursearchitectdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client25CoursearchitectdashboardscreenScreen", "/common/course-architect-dashboard");
    }
}

