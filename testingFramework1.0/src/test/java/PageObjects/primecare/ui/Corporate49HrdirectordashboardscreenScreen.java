package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate49HrdirectordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 49;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectordashboard-content')]")
	private WebElement hrdirectordashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectordashboard-screen')]")
	private WebElement hrdirectordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectordashboard-btn-1')]")
	private WebElement hrdirectordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectordashboard-title')]")
	private WebElement hrdirectordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectordashboard-btn-3')]")
	private WebElement hrdirectordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectordashboard-btn-2')]")
	private WebElement hrdirectordashboardBtn2;

    public Corporate49HrdirectordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate49HrdirectordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate49HrdirectordashboardscreenScreen", "/offices/corporate/roles/hr_director/dashboard");
    }
}

