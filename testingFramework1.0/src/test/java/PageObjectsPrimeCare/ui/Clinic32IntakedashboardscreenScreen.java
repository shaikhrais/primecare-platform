package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic32IntakedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 32;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-btn-1')]")
	private WebElement intakedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-btn-3')]")
	private WebElement intakedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-content')]")
	private WebElement intakedashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-screen')]")
	private WebElement intakedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-btn-2')]")
	private WebElement intakedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-loading')]")
	private WebElement intakedashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakedashboard-title')]")
	private WebElement intakedashboardTitle;

    public Clinic32IntakedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic32IntakedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic32IntakedashboardscreenScreen", "/offices/clinical/roles/intake_coordinator/dashboard-dup-1");
    }
}
