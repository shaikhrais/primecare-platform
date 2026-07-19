package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client80QualityassurancedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 80;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancedashboard-btn-1')]")
	private WebElement qualityassurancedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancedashboard-loading')]")
	private WebElement qualityassurancedashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancedashboard-screen')]")
	private WebElement qualityassurancedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancedashboard-btn-3')]")
	private WebElement qualityassurancedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancedashboard-btn-2')]")
	private WebElement qualityassurancedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassurancedashboard-title')]")
	private WebElement qualityassurancedashboardTitle;

    public Client80QualityassurancedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client80QualityassurancedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client80QualityassurancedashboardscreenScreen", "/staff/quality-assurance-dashboard");
    }
}
