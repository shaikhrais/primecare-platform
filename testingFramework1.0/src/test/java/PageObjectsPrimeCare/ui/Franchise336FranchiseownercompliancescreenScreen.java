package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise336FranchiseownercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 336;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercompliance-btn-2')]")
	private WebElement franchiseownercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercompliance-btn-3')]")
	private WebElement franchiseownercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercompliance-screen')]")
	private WebElement franchiseownercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercompliance-btn-1')]")
	private WebElement franchiseownercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercompliance-content')]")
	private WebElement franchiseownercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownercompliance-title')]")
	private WebElement franchiseownercomplianceTitle;

    public Franchise336FranchiseownercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise336FranchiseownercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise336FranchiseownercompliancescreenScreen", "/offices/franchise/roles/franchise_owner/compliance");
    }
}
