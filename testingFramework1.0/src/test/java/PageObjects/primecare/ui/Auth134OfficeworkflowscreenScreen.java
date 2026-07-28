package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth134OfficeworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 134;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeworkflow-content')]")
	private WebElement officeworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeworkflow-title')]")
	private WebElement officeworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeworkflow-screen')]")
	private WebElement officeworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeworkflow-btn-1')]")
	private WebElement officeworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeworkflow-btn-2')]")
	private WebElement officeworkflowBtn2;

    public Auth134OfficeworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth134OfficeworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth134OfficeworkflowscreenScreen", "/common/office-workflow");
    }
}

