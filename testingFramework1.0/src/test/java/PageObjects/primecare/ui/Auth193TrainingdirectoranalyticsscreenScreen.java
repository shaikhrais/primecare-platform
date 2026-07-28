package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth193TrainingdirectoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 193;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectoranalytics-content')]")
	private WebElement trainingdirectoranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectoranalytics-btn-2')]")
	private WebElement trainingdirectoranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectoranalytics-title')]")
	private WebElement trainingdirectoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectoranalytics-btn-1')]")
	private WebElement trainingdirectoranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectoranalytics-screen')]")
	private WebElement trainingdirectoranalyticsScreen;

    public Auth193TrainingdirectoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth193TrainingdirectoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth193TrainingdirectoranalyticsscreenScreen", "/offices/corporate/roles/training_director/analytics");
    }
}

