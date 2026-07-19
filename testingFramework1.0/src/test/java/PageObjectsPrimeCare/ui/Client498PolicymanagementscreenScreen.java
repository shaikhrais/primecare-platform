package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client498PolicymanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 498;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policy_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-loading')]")
	private WebElement policymanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-btn-2')]")
	private WebElement policymanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-btn-1')]")
	private WebElement policymanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-btn-3')]")
	private WebElement policymanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-screen')]")
	private WebElement policymanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-title')]")
	private WebElement policymanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'policymanagement-content')]")
	private WebElement policymanagementContent;

    public Client498PolicymanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client498PolicymanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client498PolicymanagementscreenScreen", "/management/policy-management");
    }
}
