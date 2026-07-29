package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic14CnsdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 14;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cns_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-content')]")
	private WebElement cnsdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-btn-2')]")
	private WebElement cnsdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-btn-1')]")
	private WebElement cnsdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-title')]")
	private WebElement cnsdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-screen')]")
	private WebElement cnsdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-btn-3')]")
	private WebElement cnsdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cnsdashboard-loading')]")
	private WebElement cnsdashboardLoading;

    public Clinic14CnsdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic14CnsdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic14CnsdashboardscreenScreen", "/clinical/cns-dashboard");
    }
}

