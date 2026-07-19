package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client581BillingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 581;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-btn-1')]")
	private WebElement billingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-btn-3')]")
	private WebElement billingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-btn-2')]")
	private WebElement billingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing-loading')]")
	private WebElement billingLoading;

    public Client581BillingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client581BillingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client581BillingscreenScreen", "/common/billing");
    }
}
