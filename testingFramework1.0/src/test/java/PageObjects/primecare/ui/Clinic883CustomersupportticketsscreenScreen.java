package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic883CustomersupportticketsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 883;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_tickets-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_tickets-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_tickets-content')]")
	private WebElement primaryContent;

    public Clinic883CustomersupportticketsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic883CustomersupportticketsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic883CustomersupportticketsscreenScreen", "/generated/customer-support-tickets");
    }
}

