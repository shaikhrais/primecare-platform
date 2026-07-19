package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth201CompliancemanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 201;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliance_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerworkflow-title')]")
	private WebElement compliancemanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerworkflow-btn-1')]")
	private WebElement compliancemanagerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerworkflow-btn-2')]")
	private WebElement compliancemanagerworkflowBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerworkflow-screen')]")
	private WebElement compliancemanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'compliancemanagerworkflow-content')]")
	private WebElement compliancemanagerworkflowContent;

    public Auth201CompliancemanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth201CompliancemanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth201CompliancemanagerworkflowscreenScreen", "/management/compliance-manager-workflow");
    }
}
