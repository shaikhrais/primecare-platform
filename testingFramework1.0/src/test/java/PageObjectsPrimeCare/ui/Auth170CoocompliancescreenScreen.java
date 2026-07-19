package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth170CoocompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 170;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-content')]")
	private WebElement coocomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-btn-3')]")
	private WebElement coocomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-btn-1')]")
	private WebElement coocomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-btn-2')]")
	private WebElement coocomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-screen')]")
	private WebElement coocomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-loading')]")
	private WebElement coocomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coocompliance-title')]")
	private WebElement coocomplianceTitle;

    public Auth170CoocompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth170CoocompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth170CoocompliancescreenScreen", "/offices/corporate/roles/coo/compliance-view");
    }
}
