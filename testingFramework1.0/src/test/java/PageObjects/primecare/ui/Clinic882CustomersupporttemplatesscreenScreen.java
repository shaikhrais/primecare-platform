package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic882CustomersupporttemplatesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 882;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_templates-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_templates-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_templates-content')]")
	private WebElement primaryContent;

    public Clinic882CustomersupporttemplatesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic882CustomersupporttemplatesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic882CustomersupporttemplatesscreenScreen", "/generated/customer-support-templates");
    }
}

