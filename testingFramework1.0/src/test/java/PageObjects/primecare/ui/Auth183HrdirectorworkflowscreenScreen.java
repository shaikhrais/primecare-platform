package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth183HrdirectorworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 183;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorworkflow-content')]")
	private WebElement hrdirectorworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorworkflow-screen')]")
	private WebElement hrdirectorworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorworkflow-btn-1')]")
	private WebElement hrdirectorworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorworkflow-title')]")
	private WebElement hrdirectorworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectorworkflow-btn-2')]")
	private WebElement hrdirectorworkflowBtn2;

    public Auth183HrdirectorworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth183HrdirectorworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth183HrdirectorworkflowscreenScreen", "/executive/hr-director-workflow");
    }
}

