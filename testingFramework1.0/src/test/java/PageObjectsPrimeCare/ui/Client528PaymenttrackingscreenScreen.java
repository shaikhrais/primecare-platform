package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client528PaymenttrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 528;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payment_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payment_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'payment_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-btn-5')]")
	private WebElement paymenttrackingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-btn-3')]")
	private WebElement paymenttrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-loading')]")
	private WebElement paymenttrackingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-title')]")
	private WebElement paymenttrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-content')]")
	private WebElement paymenttrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-screen')]")
	private WebElement paymenttrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-btn-1')]")
	private WebElement paymenttrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-btn-2')]")
	private WebElement paymenttrackingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'paymenttracking-btn-4')]")
	private WebElement paymenttrackingBtn4;

    public Client528PaymenttrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client528PaymenttrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client528PaymenttrackingscreenScreen", "/staff/payment-tracking");
    }
}
