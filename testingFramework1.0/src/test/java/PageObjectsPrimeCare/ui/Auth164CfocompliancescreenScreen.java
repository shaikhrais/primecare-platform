package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth164CfocompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 164;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-btn-2')]")
	private WebElement cfocomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-btn-3')]")
	private WebElement cfocomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-loading')]")
	private WebElement cfocomplianceLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-btn-1')]")
	private WebElement cfocomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-title')]")
	private WebElement cfocomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-content')]")
	private WebElement cfocomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfocompliance-screen')]")
	private WebElement cfocomplianceScreen;

    public Auth164CfocompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth164CfocompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth164CfocompliancescreenScreen", "/executive/cfo-compliance");
    }
}
