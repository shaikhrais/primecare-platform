package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic799AdminreconciliationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 799;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_reconciliation-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_reconciliation-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_reconciliation-content')]")
	private WebElement primaryContent;

    public Clinic799AdminreconciliationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic799AdminreconciliationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic799AdminreconciliationscreenScreen", "/offices/franchise/roles/admin/reconciliation");
    }
}

