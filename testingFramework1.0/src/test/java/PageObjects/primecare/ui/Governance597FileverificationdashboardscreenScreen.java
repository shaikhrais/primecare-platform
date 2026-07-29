package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance597FileverificationdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 597;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'file_verification_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'file_verification_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'file_verification_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'fileverificationdashboard-content')]")
	private WebElement fileverificationdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'fileverificationdashboard-btn-3')]")
	private WebElement fileverificationdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'fileverificationdashboard-screen')]")
	private WebElement fileverificationdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'fileverificationdashboard-btn-2')]")
	private WebElement fileverificationdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'fileverificationdashboard-title')]")
	private WebElement fileverificationdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'fileverificationdashboard-btn-1')]")
	private WebElement fileverificationdashboardBtn1;

    public Governance597FileverificationdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance597FileverificationdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance597FileverificationdashboardscreenScreen", "/common/file-verification-dashboard");
    }
}

