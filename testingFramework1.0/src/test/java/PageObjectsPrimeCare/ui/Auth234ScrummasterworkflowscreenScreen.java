package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth234ScrummasterworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 234;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-btn-2')]")
	private WebElement scrummasterworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-btn-1')]")
	private WebElement scrummasterworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-btn-3')]")
	private WebElement scrummasterworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-loading')]")
	private WebElement scrummasterworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-title')]")
	private WebElement scrummasterworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-content')]")
	private WebElement scrummasterworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterworkflow-screen')]")
	private WebElement scrummasterworkflowScreen;

    public Auth234ScrummasterworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth234ScrummasterworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth234ScrummasterworkflowscreenScreen", "/management/scrum-master-workflow");
    }
}
