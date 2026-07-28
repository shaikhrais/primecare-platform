package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth167CisocompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 167;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-title')]")
	private WebElement cisocomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-btn-1')]")
	private WebElement cisocomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-btn-3')]")
	private WebElement cisocomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-btn-2')]")
	private WebElement cisocomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-content')]")
	private WebElement cisocomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-screen')]")
	private WebElement cisocomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisocompliance-loading')]")
	private WebElement cisocomplianceLoading;

    public Auth167CisocompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth167CisocompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth167CisocompliancescreenScreen", "/executive/ciso-compliance");
    }
}

