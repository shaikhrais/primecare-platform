package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance58GovernanceofficerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 58;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerdashboard-content')]")
	private WebElement governanceofficerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerdashboard-title')]")
	private WebElement governanceofficerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerdashboard-btn-3')]")
	private WebElement governanceofficerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerdashboard-btn-2')]")
	private WebElement governanceofficerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerdashboard-screen')]")
	private WebElement governanceofficerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerdashboard-btn-1')]")
	private WebElement governanceofficerdashboardBtn1;

    public Governance58GovernanceofficerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance58GovernanceofficerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance58GovernanceofficerdashboardscreenScreen", "/management/governance-officer-dashboard");
    }
}

