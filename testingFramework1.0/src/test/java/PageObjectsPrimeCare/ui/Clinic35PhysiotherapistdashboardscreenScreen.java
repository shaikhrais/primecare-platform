package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic35PhysiotherapistdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 35;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistdashboard-btn-1')]")
	private WebElement physiotherapistdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistdashboard-loading')]")
	private WebElement physiotherapistdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistdashboard-btn-3')]")
	private WebElement physiotherapistdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistdashboard-title')]")
	private WebElement physiotherapistdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistdashboard-screen')]")
	private WebElement physiotherapistdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistdashboard-btn-2')]")
	private WebElement physiotherapistdashboardBtn2;

    public Clinic35PhysiotherapistdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic35PhysiotherapistdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic35PhysiotherapistdashboardscreenScreen", "/offices/clinical/roles/physiotherapist/dashboard");
    }
}
