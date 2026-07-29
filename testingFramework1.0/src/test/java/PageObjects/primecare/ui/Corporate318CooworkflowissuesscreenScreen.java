package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate318CooworkflowissuesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 318;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow_issues-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow_issues-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_workflow_issues-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-screen')]")
	private WebElement cooworkflowissuesScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-btn-3')]")
	private WebElement cooworkflowissuesBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-btn-1')]")
	private WebElement cooworkflowissuesBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-btn-2')]")
	private WebElement cooworkflowissuesBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-loading')]")
	private WebElement cooworkflowissuesLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-title')]")
	private WebElement cooworkflowissuesTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooworkflowissues-content')]")
	private WebElement cooworkflowissuesContent;

    public Corporate318CooworkflowissuesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate318CooworkflowissuesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate318CooworkflowissuesscreenScreen", "/executive/coo-workflow-issues");
    }
}

