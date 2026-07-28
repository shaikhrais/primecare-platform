package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client37QadashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 37;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-btn-3')]")
	private WebElement qadashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-content')]")
	private WebElement qadashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-btn-2')]")
	private WebElement qadashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-screen')]")
	private WebElement qadashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-loading')]")
	private WebElement qadashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-btn-1')]")
	private WebElement qadashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qadashboard-title')]")
	private WebElement qadashboardTitle;

    public Client37QadashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client37QadashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client37QadashboardscreenScreen", "/offices/support/roles/quality_assurance/dashboard");
    }
}

