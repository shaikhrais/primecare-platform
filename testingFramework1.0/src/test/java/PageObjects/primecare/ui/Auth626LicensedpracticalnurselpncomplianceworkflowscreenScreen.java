package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth626LicensedpracticalnurselpncomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 626;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_workflow-content')]")
	private WebElement primaryContent;

    public Auth626LicensedpracticalnurselpncomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth626LicensedpracticalnurselpncomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth626LicensedpracticalnurselpncomplianceworkflowscreenScreen", "/rpn/lpn-workflow");
    }
}

