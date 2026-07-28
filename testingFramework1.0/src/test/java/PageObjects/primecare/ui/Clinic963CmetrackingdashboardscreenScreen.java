package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic963CmetrackingdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 963;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'c_m_e_tracking_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'c_m_e_tracking_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'c_m_e_tracking_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cme_tracking_dashboard_iconbutton_button_1')]")
	private WebElement cmeTrackingDashboardIconbuttonButton1;

    public Clinic963CmetrackingdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic963CmetrackingdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic963CmetrackingdashboardscreenScreen", "/generated/c-m-e-tracking-dashboard");
    }
}

