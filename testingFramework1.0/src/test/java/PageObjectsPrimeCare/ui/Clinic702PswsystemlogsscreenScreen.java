package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic702PswsystemlogsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 702;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_system_logs-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_system_logs-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_system_logs-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswlogs-btn-export')]")
	private WebElement pswlogsBtnExport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswlogs-btn-report')]")
	private WebElement pswlogsBtnReport;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswsystemlogs-content')]")
	private WebElement pswsystemlogsContent;

    public Clinic702PswsystemlogsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic702PswsystemlogsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic702PswsystemlogsscreenScreen", "/generated/psw-system-logs");
    }
}
