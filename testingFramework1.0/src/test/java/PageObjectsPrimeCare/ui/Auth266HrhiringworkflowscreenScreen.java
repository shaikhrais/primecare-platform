package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth266HrhiringworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 266;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringworkflow-btn-3')]")
	private WebElement hrhiringworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringworkflow-content')]")
	private WebElement hrhiringworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringworkflow-screen')]")
	private WebElement hrhiringworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringworkflow-btn-2')]")
	private WebElement hrhiringworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringworkflow-title')]")
	private WebElement hrhiringworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringworkflow-btn-1')]")
	private WebElement hrhiringworkflowBtn1;

    public Auth266HrhiringworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth266HrhiringworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth266HrhiringworkflowscreenScreen", "/staff/hr-hiring-workflow");
    }
}
