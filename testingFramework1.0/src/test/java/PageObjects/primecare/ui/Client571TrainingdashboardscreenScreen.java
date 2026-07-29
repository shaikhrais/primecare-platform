package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client571TrainingdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 571;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-screen')]")
	private WebElement trainingdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-btn-2')]")
	private WebElement trainingdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-btn-4')]")
	private WebElement trainingdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-title')]")
	private WebElement trainingdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-content')]")
	private WebElement trainingdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-btn-1')]")
	private WebElement trainingdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-loading')]")
	private WebElement trainingdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-btn-3')]")
	private WebElement trainingdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdashboard-btn-5')]")
	private WebElement trainingdashboardBtn5;

    public Client571TrainingdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client571TrainingdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client571TrainingdashboardscreenScreen", "/staff/training-dashboard");
    }
}

