package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate478RiskmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 478;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'risk_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-btn-2')]")
	private WebElement riskmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-screen')]")
	private WebElement riskmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-btn-3')]")
	private WebElement riskmanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-content')]")
	private WebElement riskmanagementContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-btn-1')]")
	private WebElement riskmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-loading')]")
	private WebElement riskmanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'riskmanagement-title')]")
	private WebElement riskmanagementTitle;

    public Corporate478RiskmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate478RiskmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate478RiskmanagementscreenScreen", "/executive/risk-management");
    }
}
