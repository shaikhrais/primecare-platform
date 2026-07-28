package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth115DynamicscreencompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 115;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-screen')]")
	private WebElement dynamiccomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-content')]")
	private WebElement dynamiccomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-btn-3')]")
	private WebElement dynamiccomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-title')]")
	private WebElement dynamiccomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-loading')]")
	private WebElement dynamiccomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-btn-1')]")
	private WebElement dynamiccomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamiccompliance-btn-2')]")
	private WebElement dynamiccomplianceBtn2;

    public Auth115DynamicscreencompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth115DynamicscreencompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth115DynamicscreencompliancescreenScreen", "/common/dynamic-compliance");
    }
}

