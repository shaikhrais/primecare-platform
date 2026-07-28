package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic866LocalmarketingmanagerbudgetscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 866;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_budget-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_budget-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_budget-content')]")
	private WebElement primaryContent;

    public Clinic866LocalmarketingmanagerbudgetscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic866LocalmarketingmanagerbudgetscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic866LocalmarketingmanagerbudgetscreenScreen", "/generated/local-marketing-manager-budget");
    }
}

