package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic652PartnershipmanagerrenewalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 652;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_renewals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_renewals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_renewals-content')]")
	private WebElement primaryContent;

    public Clinic652PartnershipmanagerrenewalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic652PartnershipmanagerrenewalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic652PartnershipmanagerrenewalsscreenScreen", "/offices/business_development/roles/partnership_manager/renewals");
    }
}
