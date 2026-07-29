package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client53TrainingdirectordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 53;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-btn-1')]")
	private WebElement trainingdirectordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-btn-3')]")
	private WebElement trainingdirectordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-btn-5')]")
	private WebElement trainingdirectordashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-btn-4')]")
	private WebElement trainingdirectordashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-content')]")
	private WebElement trainingdirectordashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-screen')]")
	private WebElement trainingdirectordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-btn-2')]")
	private WebElement trainingdirectordashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectordashboard-title')]")
	private WebElement trainingdirectordashboardTitle;

    public Client53TrainingdirectordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client53TrainingdirectordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client53TrainingdirectordashboardscreenScreen", "/offices/corporate/roles/training_director/dashboard");
    }
}

