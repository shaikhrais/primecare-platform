package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth219LocalmarketingmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 219;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerworkflow-title')]")
	private WebElement localmarketingmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerworkflow-screen')]")
	private WebElement localmarketingmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerworkflow-content')]")
	private WebElement localmarketingmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerworkflow-btn-1')]")
	private WebElement localmarketingmanagerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerworkflow-btn-2')]")
	private WebElement localmarketingmanagerworkflowBtn2;

    public Auth219LocalmarketingmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth219LocalmarketingmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth219LocalmarketingmanagerworkflowscreenScreen", "/management/local-marketing-manager-workflow");
    }
}

