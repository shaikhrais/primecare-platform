package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate48FinancedirectordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 48;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'finance_director_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-screen')]")
	private WebElement financedirectordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-title')]")
	private WebElement financedirectordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-content')]")
	private WebElement financedirectordashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-btn-1')]")
	private WebElement financedirectordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-btn-3')]")
	private WebElement financedirectordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-btn-5')]")
	private WebElement financedirectordashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-btn-4')]")
	private WebElement financedirectordashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'financedirectordashboard-btn-2')]")
	private WebElement financedirectordashboardBtn2;

    public Corporate48FinancedirectordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate48FinancedirectordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate48FinancedirectordashboardscreenScreen", "/offices/corporate/roles/finance_director/dashboard");
    }
}

