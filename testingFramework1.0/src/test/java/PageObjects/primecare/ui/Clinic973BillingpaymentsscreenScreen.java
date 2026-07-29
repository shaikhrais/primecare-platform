package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic973BillingpaymentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 973;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_payments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_payments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_payments-content')]")
	private WebElement primaryContent;

    public Clinic973BillingpaymentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic973BillingpaymentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic973BillingpaymentsscreenScreen", "/generated/billing-payments");
    }
}

