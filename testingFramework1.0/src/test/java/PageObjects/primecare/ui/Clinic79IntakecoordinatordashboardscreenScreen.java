package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic79IntakecoordinatordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 79;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intake_coordinator_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordashboard-btn-3')]")
	private WebElement intakecoordinatordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordashboard-screen')]")
	private WebElement intakecoordinatordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordashboard-btn-1')]")
	private WebElement intakecoordinatordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordashboard-btn-2')]")
	private WebElement intakecoordinatordashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordashboard-title')]")
	private WebElement intakecoordinatordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'intakecoordinatordashboard-loading')]")
	private WebElement intakecoordinatordashboardLoading;

    public Clinic79IntakecoordinatordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic79IntakecoordinatordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic79IntakecoordinatordashboardscreenScreen", "/offices/clinical/roles/intake_coordinator/dashboard");
    }
}

