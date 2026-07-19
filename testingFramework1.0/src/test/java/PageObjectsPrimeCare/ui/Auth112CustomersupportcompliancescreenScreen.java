package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth112CustomersupportcompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 112;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportcompliance-btn-3')]")
	private WebElement customersupportcomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportcompliance-title')]")
	private WebElement customersupportcomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportcompliance-btn-2')]")
	private WebElement customersupportcomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportcompliance-screen')]")
	private WebElement customersupportcomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportcompliance-btn-1')]")
	private WebElement customersupportcomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportcompliance-content')]")
	private WebElement customersupportcomplianceContent;

    public Auth112CustomersupportcompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth112CustomersupportcompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth112CustomersupportcompliancescreenScreen", "/common/customer-support-compliance");
    }
}
