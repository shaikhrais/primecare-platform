package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth119FamilymemberworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 119;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberworkflow-btn-2')]")
	private WebElement familymemberworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberworkflow-title')]")
	private WebElement familymemberworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberworkflow-screen')]")
	private WebElement familymemberworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberworkflow-btn-1')]")
	private WebElement familymemberworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberworkflow-content')]")
	private WebElement familymemberworkflowContent;

    public Auth119FamilymemberworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth119FamilymemberworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth119FamilymemberworkflowscreenScreen", "/common/family-member-workflow");
    }
}

