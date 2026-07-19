package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth173CtocompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 173;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-loading')]")
	private WebElement ctocomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-title')]")
	private WebElement ctocomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-btn-1')]")
	private WebElement ctocomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-content')]")
	private WebElement ctocomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-btn-2')]")
	private WebElement ctocomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-btn-3')]")
	private WebElement ctocomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctocompliance-screen')]")
	private WebElement ctocomplianceScreen;

    public Auth173CtocompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth173CtocompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth173CtocompliancescreenScreen", "/executive/cto-compliance");
    }
}
