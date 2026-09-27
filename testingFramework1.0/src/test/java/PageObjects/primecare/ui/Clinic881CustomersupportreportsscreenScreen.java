package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic881CustomersupportreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 881;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_reports-content')]")
	private WebElement primaryContent;

    public Clinic881CustomersupportreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic881CustomersupportreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic881CustomersupportreportsscreenScreen", "/generated/customer-support-reports");
    }
}

