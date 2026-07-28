package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth142PortalcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 142;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-screen')]")
	private WebElement portalcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-title')]")
	private WebElement portalcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-btn-4')]")
	private WebElement portalcomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-btn-1')]")
	private WebElement portalcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-btn-3')]")
	private WebElement portalcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-loading')]")
	private WebElement portalcomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-btn-2')]")
	private WebElement portalcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-btn-5')]")
	private WebElement portalcomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalcompliance-content')]")
	private WebElement portalcomplianceContent;

    public Auth142PortalcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth142PortalcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth142PortalcompliancescreenScreen", "/common/portal-compliance");
    }
}

