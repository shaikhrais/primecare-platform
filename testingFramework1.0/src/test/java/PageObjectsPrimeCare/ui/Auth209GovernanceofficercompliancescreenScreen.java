package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth209GovernanceofficercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 209;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governance_officer_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficercompliance-screen')]")
	private WebElement governanceofficercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficercompliance-btn-3')]")
	private WebElement governanceofficercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficercompliance-content')]")
	private WebElement governanceofficercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficercompliance-title')]")
	private WebElement governanceofficercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficercompliance-btn-2')]")
	private WebElement governanceofficercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'governanceofficercompliance-btn-1')]")
	private WebElement governanceofficercomplianceBtn1;

    public Auth209GovernanceofficercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth209GovernanceofficercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth209GovernanceofficercompliancescreenScreen", "/management/governance-officer-compliance");
    }
}
