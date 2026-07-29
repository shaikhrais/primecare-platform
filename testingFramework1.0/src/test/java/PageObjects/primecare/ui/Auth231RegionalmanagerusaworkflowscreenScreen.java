package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth231RegionalmanagerusaworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 231;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaworkflow-btn-2')]")
	private WebElement regionalmanagerusaworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaworkflow-screen')]")
	private WebElement regionalmanagerusaworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaworkflow-content')]")
	private WebElement regionalmanagerusaworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaworkflow-title')]")
	private WebElement regionalmanagerusaworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaworkflow-btn-1')]")
	private WebElement regionalmanagerusaworkflowBtn1;

    public Auth231RegionalmanagerusaworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth231RegionalmanagerusaworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth231RegionalmanagerusaworkflowscreenScreen", "/management/regional-manager-usa-workflow");
    }
}

