package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth233ScrummastercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 233;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummastercompliance-btn-3')]")
	private WebElement scrummastercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummastercompliance-screen')]")
	private WebElement scrummastercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummastercompliance-content')]")
	private WebElement scrummastercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummastercompliance-btn-2')]")
	private WebElement scrummastercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummastercompliance-title')]")
	private WebElement scrummastercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummastercompliance-btn-1')]")
	private WebElement scrummastercomplianceBtn1;

    public Auth233ScrummastercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth233ScrummastercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth233ScrummastercompliancescreenScreen", "/management/scrum-master-compliance");
    }
}
