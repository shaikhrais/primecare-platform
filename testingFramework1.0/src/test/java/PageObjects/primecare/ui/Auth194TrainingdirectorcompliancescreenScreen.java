package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth194TrainingdirectorcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 194;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorcompliance-title')]")
	private WebElement trainingdirectorcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorcompliance-btn-3')]")
	private WebElement trainingdirectorcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorcompliance-btn-2')]")
	private WebElement trainingdirectorcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorcompliance-content')]")
	private WebElement trainingdirectorcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorcompliance-screen')]")
	private WebElement trainingdirectorcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorcompliance-btn-1')]")
	private WebElement trainingdirectorcomplianceBtn1;

    public Auth194TrainingdirectorcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth194TrainingdirectorcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth194TrainingdirectorcompliancescreenScreen", "/executive/training-director-compliance");
    }
}

