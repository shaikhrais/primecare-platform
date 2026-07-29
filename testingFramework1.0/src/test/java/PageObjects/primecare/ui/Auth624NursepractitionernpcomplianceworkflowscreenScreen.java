package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth624NursepractitionernpcomplianceworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 624;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'np_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) compliance workflow-title')]")
	private WebElement nursepractitionernpcomplianceworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) compliance workflow-btn-1')]")
	private WebElement nursepractitionernpcomplianceworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) compliance workflow-content')]")
	private WebElement nursepractitionernpcomplianceworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nurse practitioner (np) compliance workflow-screen')]")
	private WebElement nursepractitionernpcomplianceworkflowScreen;

    public Auth624NursepractitionernpcomplianceworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth624NursepractitionernpcomplianceworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth624NursepractitionernpcomplianceworkflowscreenScreen", "/rn/np-workflow");
    }
}

