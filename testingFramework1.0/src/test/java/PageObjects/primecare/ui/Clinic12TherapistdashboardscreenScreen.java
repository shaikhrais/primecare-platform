package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic12TherapistdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 12;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapist_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-btn-3')]")
	private WebElement therapistdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-btn-2')]")
	private WebElement therapistdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-content')]")
	private WebElement therapistdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-screen')]")
	private WebElement therapistdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-btn-4')]")
	private WebElement therapistdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-btn-1')]")
	private WebElement therapistdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-btn-5')]")
	private WebElement therapistdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'therapistdashboard-title')]")
	private WebElement therapistdashboardTitle;

    public Clinic12TherapistdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic12TherapistdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic12TherapistdashboardscreenScreen", "/offices/clinical/roles/therapist/dashboard");
    }
}

