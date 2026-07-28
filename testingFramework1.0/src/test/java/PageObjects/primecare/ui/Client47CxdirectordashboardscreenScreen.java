package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client47CxdirectordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 47;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cx_director_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-btn-2')]")
	private WebElement cxdirectordashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-btn-3')]")
	private WebElement cxdirectordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-content')]")
	private WebElement cxdirectordashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-btn-1')]")
	private WebElement cxdirectordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-btn-4')]")
	private WebElement cxdirectordashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-title')]")
	private WebElement cxdirectordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-screen')]")
	private WebElement cxdirectordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cxdirectordashboard-btn-5')]")
	private WebElement cxdirectordashboardBtn5;

    public Client47CxdirectordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client47CxdirectordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client47CxdirectordashboardscreenScreen", "/offices/corporate/roles/cx_director/dashboard");
    }
}

