package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic870LocalmarketingmanagerleadsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 870;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_leads-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_leads-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_leads-content')]")
	private WebElement primaryContent;

    public Clinic870LocalmarketingmanagerleadsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic870LocalmarketingmanagerleadsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic870LocalmarketingmanagerleadsscreenScreen", "/generated/local-marketing-manager-leads");
    }
}
