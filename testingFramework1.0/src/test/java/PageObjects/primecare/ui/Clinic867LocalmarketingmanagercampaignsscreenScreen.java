package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic867LocalmarketingmanagercampaignsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 867;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_campaigns-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_campaigns-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_campaigns-content')]")
	private WebElement primaryContent;

    public Clinic867LocalmarketingmanagercampaignsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic867LocalmarketingmanagercampaignsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic867LocalmarketingmanagercampaignsscreenScreen", "/generated/local-marketing-manager-campaigns");
    }
}

