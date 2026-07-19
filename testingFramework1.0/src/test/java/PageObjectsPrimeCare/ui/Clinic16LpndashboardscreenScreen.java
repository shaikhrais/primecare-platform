package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic16LpndashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 16;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-btn-1')]")
	private WebElement lpndashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-btn-3')]")
	private WebElement lpndashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-loading')]")
	private WebElement lpndashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-btn-2')]")
	private WebElement lpndashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-screen')]")
	private WebElement lpndashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-title')]")
	private WebElement lpndashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpndashboard-content')]")
	private WebElement lpndashboardContent;

    public Clinic16LpndashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic16LpndashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic16LpndashboardscreenScreen", "/clinical/lpn-dashboard");
    }
}
