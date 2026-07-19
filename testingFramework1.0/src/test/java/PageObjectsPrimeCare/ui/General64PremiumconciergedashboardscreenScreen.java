package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class General64PremiumconciergedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 64;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premiumconciergedashboard-content')]")
	private WebElement premiumconciergedashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premiumconciergedashboard-btn-1')]")
	private WebElement premiumconciergedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premiumconciergedashboard-screen')]")
	private WebElement premiumconciergedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premiumconciergedashboard-btn-2')]")
	private WebElement premiumconciergedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premiumconciergedashboard-btn-3')]")
	private WebElement premiumconciergedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premiumconciergedashboard-title')]")
	private WebElement premiumconciergedashboardTitle;

    public General64PremiumconciergedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public General64PremiumconciergedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "General64PremiumconciergedashboardscreenScreen", "/management/premium-concierge-dashboard");
    }
}
