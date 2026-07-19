package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic798AdminpaymentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 798;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_payments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_payments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_payments-content')]")
	private WebElement primaryContent;

    public Clinic798AdminpaymentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic798AdminpaymentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic798AdminpaymentsscreenScreen", "/offices/franchise/roles/admin/payments");
    }
}
