package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic802BillingadmininvoicesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 802;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_invoices-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_invoices-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_invoices-content')]")
	private WebElement primaryContent;

    public Clinic802BillingadmininvoicesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic802BillingadmininvoicesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic802BillingadmininvoicesscreenScreen", "/offices/franchise/roles/billing_admin/invoices");
    }
}
