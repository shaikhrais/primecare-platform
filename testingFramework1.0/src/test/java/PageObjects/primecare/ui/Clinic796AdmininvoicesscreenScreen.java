package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic796AdmininvoicesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 796;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_invoices-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_invoices-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_invoices-content')]")
	private WebElement primaryContent;

    public Clinic796AdmininvoicesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic796AdmininvoicesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic796AdmininvoicesscreenScreen", "/offices/franchise/roles/admin/invoices");
    }
}

