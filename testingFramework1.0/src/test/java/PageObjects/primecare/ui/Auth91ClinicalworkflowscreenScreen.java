package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth91ClinicalworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 91;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinical_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalworkflow-btn-2')]")
	private WebElement clinicalworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalworkflow-btn-1')]")
	private WebElement clinicalworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalworkflow-content')]")
	private WebElement clinicalworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalworkflow-screen')]")
	private WebElement clinicalworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clinicalworkflow-title')]")
	private WebElement clinicalworkflowTitle;

    public Auth91ClinicalworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth91ClinicalworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth91ClinicalworkflowscreenScreen", "/offices/clinical/roles/clinical_director/workflow");
    }
}

