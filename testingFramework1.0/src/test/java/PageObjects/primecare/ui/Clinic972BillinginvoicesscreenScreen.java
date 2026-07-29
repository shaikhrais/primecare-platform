package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic972BillinginvoicesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 972;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_invoices-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_invoices-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_invoices-content')]")
	private WebElement primaryContent;

    public Clinic972BillinginvoicesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic972BillinginvoicesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic972BillinginvoicesscreenScreen", "/generated/billing-invoices");
    }
}

