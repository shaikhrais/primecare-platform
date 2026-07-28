package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic17NpdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 17;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-screen')]")
	private WebElement npdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-btn-2')]")
	private WebElement npdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-btn-3')]")
	private WebElement npdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-loading')]")
	private WebElement npdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-btn-1')]")
	private WebElement npdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-title')]")
	private WebElement npdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'npdashboard-content')]")
	private WebElement npdashboardContent;

    public Clinic17NpdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic17NpdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic17NpdashboardscreenScreen", "/clinical/np-dashboard");
    }
}

