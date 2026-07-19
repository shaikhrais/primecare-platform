package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic880CustomersupportissuecategoriesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 880;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_issue_categories-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_issue_categories-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_issue_categories-content')]")
	private WebElement primaryContent;

    public Clinic880CustomersupportissuecategoriesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic880CustomersupportissuecategoriesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic880CustomersupportissuecategoriesscreenScreen", "/generated/customer-support-issue-categories");
    }
}
