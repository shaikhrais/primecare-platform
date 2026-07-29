package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic800AdminrefundsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 800;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_refunds-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_refunds-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_refunds-content')]")
	private WebElement primaryContent;

    public Clinic800AdminrefundsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic800AdminrefundsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic800AdminrefundsscreenScreen", "/offices/franchise/roles/admin/refunds");
    }
}

