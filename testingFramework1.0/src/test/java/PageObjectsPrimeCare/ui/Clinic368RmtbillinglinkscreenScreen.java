package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic368RmtbillinglinkscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 368;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_billing_link-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_billing_link-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_billing_link-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-screen')]")
	private WebElement rmtbillinglinkScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-title')]")
	private WebElement rmtbillinglinkTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-btn-1')]")
	private WebElement rmtbillinglinkBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-btn-3')]")
	private WebElement rmtbillinglinkBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-loading')]")
	private WebElement rmtbillinglinkLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-content')]")
	private WebElement rmtbillinglinkContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtbillinglink-btn-2')]")
	private WebElement rmtbillinglinkBtn2;

    public Clinic368RmtbillinglinkscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic368RmtbillinglinkscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic368RmtbillinglinkscreenScreen", "/offices/clinical/roles/rmt/billing-link");
    }
}
