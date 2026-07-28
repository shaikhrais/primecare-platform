package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth283TrainingcoordinatorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 283;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_coordinator_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-btn-1')]")
	private WebElement trainingcoordinatorcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-btn-3')]")
	private WebElement trainingcoordinatorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-screen')]")
	private WebElement trainingcoordinatorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-btn-2')]")
	private WebElement trainingcoordinatorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-btn-5')]")
	private WebElement trainingcoordinatorcomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-title')]")
	private WebElement trainingcoordinatorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-content')]")
	private WebElement trainingcoordinatorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingcoordinatorcompliance-btn-4')]")
	private WebElement trainingcoordinatorcomplianceBtn4;

    public Auth283TrainingcoordinatorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth283TrainingcoordinatorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth283TrainingcoordinatorcompliancescreenScreen", "/staff/training-coordinator-compliance");
    }
}

