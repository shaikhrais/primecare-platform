package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth104ChiropractorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 104;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorworkflow-content')]")
	private WebElement chiropractorworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorworkflow-btn-1')]")
	private WebElement chiropractorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorworkflow-screen')]")
	private WebElement chiropractorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorworkflow-title')]")
	private WebElement chiropractorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractorworkflow-btn-2')]")
	private WebElement chiropractorworkflowBtn2;

    public Auth104ChiropractorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth104ChiropractorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth104ChiropractorworkflowscreenScreen", "/offices/clinical/roles/chiropractor/workflow");
    }
}

