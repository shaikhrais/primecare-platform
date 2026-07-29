package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic674ClientpaymentsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 674;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_payments-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_payments-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_payments-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientpaymentsscreen-screen')]")
	private WebElement clientpaymentsscreenScreen;

    public Clinic674ClientpaymentsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic674ClientpaymentsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic674ClientpaymentsscreenScreen", "/generated/client-payments");
    }
}

