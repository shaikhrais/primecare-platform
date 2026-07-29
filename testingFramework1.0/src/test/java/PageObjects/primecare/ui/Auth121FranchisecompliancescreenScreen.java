package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth121FranchisecompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 121;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecompliance-screen')]")
	private WebElement franchisecomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecompliance-title')]")
	private WebElement franchisecomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecompliance-content')]")
	private WebElement franchisecomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecompliance-btn-1')]")
	private WebElement franchisecomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecompliance-btn-3')]")
	private WebElement franchisecomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisecompliance-btn-2')]")
	private WebElement franchisecomplianceBtn2;

    public Auth121FranchisecompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth121FranchisecompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth121FranchisecompliancescreenScreen", "/common/franchise-compliance");
    }
}

