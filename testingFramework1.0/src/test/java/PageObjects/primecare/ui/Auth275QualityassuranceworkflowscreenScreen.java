package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth275QualityassuranceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 275;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'quality_assurance_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceworkflow-screen')]")
	private WebElement qualityassuranceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceworkflow-btn-1')]")
	private WebElement qualityassuranceworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceworkflow-btn-3')]")
	private WebElement qualityassuranceworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceworkflow-content')]")
	private WebElement qualityassuranceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceworkflow-title')]")
	private WebElement qualityassuranceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qualityassuranceworkflow-btn-2')]")
	private WebElement qualityassuranceworkflowBtn2;

    public Auth275QualityassuranceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth275QualityassuranceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth275QualityassuranceworkflowscreenScreen", "/staff/quality-assurance-workflow");
    }
}

