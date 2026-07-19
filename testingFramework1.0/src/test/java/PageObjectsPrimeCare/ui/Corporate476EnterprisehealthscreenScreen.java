package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate476EnterprisehealthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 476;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprise_health-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprise_health-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprise_health-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-content')]")
	private WebElement enterprisehealthContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-btn-3')]")
	private WebElement enterprisehealthBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-btn-1')]")
	private WebElement enterprisehealthBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-title')]")
	private WebElement enterprisehealthTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-screen')]")
	private WebElement enterprisehealthScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-loading')]")
	private WebElement enterprisehealthLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'enterprisehealth-btn-2')]")
	private WebElement enterprisehealthBtn2;

    public Corporate476EnterprisehealthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate476EnterprisehealthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate476EnterprisehealthscreenScreen", "/executive/enterprise-health");
    }
}
