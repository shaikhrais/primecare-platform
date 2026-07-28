package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth186LegalworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 186;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-screen')]")
	private WebElement legalworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-btn-2')]")
	private WebElement legalworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-loading')]")
	private WebElement legalworkflowLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-btn-1')]")
	private WebElement legalworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-title')]")
	private WebElement legalworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-btn-3')]")
	private WebElement legalworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legalworkflow-content')]")
	private WebElement legalworkflowContent;

    public Auth186LegalworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth186LegalworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth186LegalworkflowscreenScreen", "/executive/legal-workflow");
    }
}

