package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic809MarketingmanagercampaignsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 809;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_manager_campaigns-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_manager_campaigns-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_manager_campaigns-content')]")
	private WebElement primaryContent;

    public Clinic809MarketingmanagercampaignsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic809MarketingmanagercampaignsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic809MarketingmanagercampaignsscreenScreen", "/offices/franchise/roles/marketing_manager/campaigns");
    }
}
