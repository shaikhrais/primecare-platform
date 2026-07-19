package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client83TrainingcoordinatordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 83;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatordashboard-btn-2')]")
	private WebElement trainingcoordinatordashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatordashboard-btn-3')]")
	private WebElement trainingcoordinatordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatordashboard-screen')]")
	private WebElement trainingcoordinatordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatordashboard-btn-1')]")
	private WebElement trainingcoordinatordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatordashboard-loading')]")
	private WebElement trainingcoordinatordashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatordashboard-title')]")
	private WebElement trainingcoordinatordashboardTitle;

    public Client83TrainingcoordinatordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client83TrainingcoordinatordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client83TrainingcoordinatordashboardscreenScreen", "/offices/support/roles/training_coordinator/dashboard");
    }
}
