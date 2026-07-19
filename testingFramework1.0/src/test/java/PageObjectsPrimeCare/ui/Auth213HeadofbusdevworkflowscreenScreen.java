package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth213HeadofbusdevworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 213;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_bus_dev_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevworkflow-screen')]")
	private WebElement headofbusdevworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevworkflow-title')]")
	private WebElement headofbusdevworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevworkflow-content')]")
	private WebElement headofbusdevworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevworkflow-btn-2')]")
	private WebElement headofbusdevworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'headofbusdevworkflow-btn-1')]")
	private WebElement headofbusdevworkflowBtn1;

    public Auth213HeadofbusdevworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth213HeadofbusdevworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth213HeadofbusdevworkflowscreenScreen", "/management/head-of-bus-dev-workflow");
    }
}
