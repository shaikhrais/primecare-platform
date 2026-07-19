package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic651PartnershipmanagerproposalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 651;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_proposals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_proposals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_proposals-content')]")
	private WebElement primaryContent;

    public Clinic651PartnershipmanagerproposalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic651PartnershipmanagerproposalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic651PartnershipmanagerproposalsscreenScreen", "/offices/business_development/roles/partnership_manager/proposals");
    }
}
