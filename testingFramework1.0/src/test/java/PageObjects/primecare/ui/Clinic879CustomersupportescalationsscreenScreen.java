package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic879CustomersupportescalationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 879;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_escalations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_escalations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_escalations-content')]")
	private WebElement primaryContent;

    public Clinic879CustomersupportescalationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic879CustomersupportescalationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic879CustomersupportescalationsscreenScreen", "/generated/customer-support-escalations");
    }
}

