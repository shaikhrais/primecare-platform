package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth230RegionalmanagerusacompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 230;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusacompliance-btn-1')]")
	private WebElement regionalmanagerusacomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusacompliance-btn-3')]")
	private WebElement regionalmanagerusacomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusacompliance-btn-2')]")
	private WebElement regionalmanagerusacomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusacompliance-title')]")
	private WebElement regionalmanagerusacomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusacompliance-screen')]")
	private WebElement regionalmanagerusacomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusacompliance-content')]")
	private WebElement regionalmanagerusacomplianceContent;

    public Auth230RegionalmanagerusacompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth230RegionalmanagerusacompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth230RegionalmanagerusacompliancescreenScreen", "/management/regional-manager-usa-compliance");
    }
}
