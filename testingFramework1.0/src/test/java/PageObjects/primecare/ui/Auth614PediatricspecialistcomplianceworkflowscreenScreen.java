package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth614PediatricspecialistcomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 614;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist compliance workflow-content')]")
	private WebElement pediatricspecialistcomplianceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist compliance workflow-title')]")
	private WebElement pediatricspecialistcomplianceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist compliance workflow-screen')]")
	private WebElement pediatricspecialistcomplianceworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pediatric specialist compliance workflow-btn-1')]")
	private WebElement pediatricspecialistcomplianceworkflowBtn1;

    public Auth614PediatricspecialistcomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth614PediatricspecialistcomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth614PediatricspecialistcomplianceworkflowscreenScreen", "/clinical/pediatric-workflow");
    }
}

