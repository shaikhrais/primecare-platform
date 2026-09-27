package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth195TrainingdirectorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 195;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_director_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorworkflow-btn-2')]")
	private WebElement trainingdirectorworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorworkflow-btn-3')]")
	private WebElement trainingdirectorworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorworkflow-content')]")
	private WebElement trainingdirectorworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorworkflow-btn-1')]")
	private WebElement trainingdirectorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorworkflow-title')]")
	private WebElement trainingdirectorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'trainingdirectorworkflow-screen')]")
	private WebElement trainingdirectorworkflowScreen;

    public Auth195TrainingdirectorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth195TrainingdirectorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth195TrainingdirectorworkflowscreenScreen", "/executive/training-director-workflow");
    }
}

