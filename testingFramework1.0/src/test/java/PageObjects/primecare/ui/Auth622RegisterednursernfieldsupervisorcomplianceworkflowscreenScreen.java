package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth622RegisterednursernfieldsupervisorcomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 622;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_field_supervisor_workflow-content')]")
	private WebElement primaryContent;

    public Auth622RegisterednursernfieldsupervisorcomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth622RegisterednursernfieldsupervisorcomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth622RegisterednursernfieldsupervisorcomplianceworkflowscreenScreen", "/rn/rn-field-supervisor-workflow");
    }
}

