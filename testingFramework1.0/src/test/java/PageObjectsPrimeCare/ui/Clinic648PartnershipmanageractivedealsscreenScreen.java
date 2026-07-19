package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic648PartnershipmanageractivedealsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 648;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_active_deals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_active_deals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_active_deals-content')]")
	private WebElement primaryContent;

    public Clinic648PartnershipmanageractivedealsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic648PartnershipmanageractivedealsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic648PartnershipmanageractivedealsscreenScreen", "/offices/business_development/roles/partnership_manager/active-deals");
    }
}
