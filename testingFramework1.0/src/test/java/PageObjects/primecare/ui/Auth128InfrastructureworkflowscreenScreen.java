package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth128InfrastructureworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 128;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-btn-1')]")
	private WebElement infrastructureworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-title')]")
	private WebElement infrastructureworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-btn-3')]")
	private WebElement infrastructureworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-loading')]")
	private WebElement infrastructureworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-content')]")
	private WebElement infrastructureworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-btn-2')]")
	private WebElement infrastructureworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructureworkflow-screen')]")
	private WebElement infrastructureworkflowScreen;

    public Auth128InfrastructureworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth128InfrastructureworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth128InfrastructureworkflowscreenScreen", "/common/infrastructure-workflow");
    }
}

