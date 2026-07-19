package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth243PswcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 243;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-btn-3')]")
	private WebElement pswcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-content')]")
	private WebElement pswcomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-loading')]")
	private WebElement pswcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-btn-1')]")
	private WebElement pswcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-title')]")
	private WebElement pswcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-btn-2')]")
	private WebElement pswcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcompliance-screen')]")
	private WebElement pswcomplianceScreen;

    public Auth243PswcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth243PswcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth243PswcompliancescreenScreen", "/offices/clinical/roles/psw/help-support");
    }
}
