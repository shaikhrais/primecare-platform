package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth278ReceptionistworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 278;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistworkflow-btn-3')]")
	private WebElement receptionistworkflowBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistworkflow-title')]")
	private WebElement receptionistworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistworkflow-screen')]")
	private WebElement receptionistworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistworkflow-content')]")
	private WebElement receptionistworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistworkflow-btn-2')]")
	private WebElement receptionistworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistworkflow-btn-1')]")
	private WebElement receptionistworkflowBtn1;

    public Auth278ReceptionistworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth278ReceptionistworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth278ReceptionistworkflowscreenScreen", "/staff/receptionist-workflow");
    }
}
