package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth140PhysiotherapistworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 140;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapist_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistworkflow-screen')]")
	private WebElement physiotherapistworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistworkflow-content')]")
	private WebElement physiotherapistworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistworkflow-title')]")
	private WebElement physiotherapistworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistworkflow-btn-2')]")
	private WebElement physiotherapistworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physiotherapistworkflow-btn-1')]")
	private WebElement physiotherapistworkflowBtn1;

    public Auth140PhysiotherapistworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth140PhysiotherapistworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth140PhysiotherapistworkflowscreenScreen", "/offices/clinical/roles/physiotherapist/workflow");
    }
}

