package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth225PartnershipmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 225;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerworkflow-btn-1')]")
	private WebElement partnershipmanagerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerworkflow-title')]")
	private WebElement partnershipmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerworkflow-content')]")
	private WebElement partnershipmanagerworkflowContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerworkflow-screen')]")
	private WebElement partnershipmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerworkflow-btn-2')]")
	private WebElement partnershipmanagerworkflowBtn2;

    public Auth225PartnershipmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth225PartnershipmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth225PartnershipmanagerworkflowscreenScreen", "/management/partnership-manager-workflow");
    }
}

