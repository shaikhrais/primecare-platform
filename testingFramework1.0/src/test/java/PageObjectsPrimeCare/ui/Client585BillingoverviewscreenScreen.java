package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client585BillingoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 585;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-content')]")
	private WebElement billingoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-btn-1')]")
	private WebElement billingoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-screen')]")
	private WebElement billingoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-loading')]")
	private WebElement billingoverviewLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-btn-3')]")
	private WebElement billingoverviewBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-title')]")
	private WebElement billingoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingoverview-btn-2')]")
	private WebElement billingoverviewBtn2;

    public Client585BillingoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client585BillingoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client585BillingoverviewscreenScreen", "/common/billing-overview");
    }
}
