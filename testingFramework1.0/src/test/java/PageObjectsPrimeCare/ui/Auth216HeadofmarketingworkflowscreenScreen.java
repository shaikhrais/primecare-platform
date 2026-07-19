package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth216HeadofmarketingworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 216;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingworkflow-btn-1')]")
	private WebElement headofmarketingworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingworkflow-content')]")
	private WebElement headofmarketingworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingworkflow-title')]")
	private WebElement headofmarketingworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingworkflow-btn-2')]")
	private WebElement headofmarketingworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofmarketingworkflow-screen')]")
	private WebElement headofmarketingworkflowScreen;

    public Auth216HeadofmarketingworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth216HeadofmarketingworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth216HeadofmarketingworkflowscreenScreen", "/management/head-of-marketing-workflow");
    }
}
