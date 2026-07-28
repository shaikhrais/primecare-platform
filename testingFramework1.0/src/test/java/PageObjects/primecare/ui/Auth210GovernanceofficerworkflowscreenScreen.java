package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth210GovernanceofficerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 210;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerworkflow-btn-1')]")
	private WebElement governanceofficerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerworkflow-title')]")
	private WebElement governanceofficerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerworkflow-screen')]")
	private WebElement governanceofficerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerworkflow-btn-2')]")
	private WebElement governanceofficerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficerworkflow-content')]")
	private WebElement governanceofficerworkflowContent;

    public Auth210GovernanceofficerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth210GovernanceofficerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth210GovernanceofficerworkflowscreenScreen", "/management/governance-officer-workflow");
    }
}

