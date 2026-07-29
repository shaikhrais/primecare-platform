package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth224PartnershipmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 224;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagercompliance-btn-3')]")
	private WebElement partnershipmanagercomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagercompliance-screen')]")
	private WebElement partnershipmanagercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagercompliance-content')]")
	private WebElement partnershipmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagercompliance-title')]")
	private WebElement partnershipmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagercompliance-btn-2')]")
	private WebElement partnershipmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagercompliance-btn-1')]")
	private WebElement partnershipmanagercomplianceBtn1;

    public Auth224PartnershipmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth224PartnershipmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth224PartnershipmanagercompliancescreenScreen", "/management/partnership-manager-compliance");
    }
}

