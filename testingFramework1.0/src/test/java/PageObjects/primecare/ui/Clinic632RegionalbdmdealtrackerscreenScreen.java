package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic632RegionalbdmdealtrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 632;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_deal_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_deal_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_deal_tracker-content')]")
	private WebElement primaryContent;

    public Clinic632RegionalbdmdealtrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic632RegionalbdmdealtrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic632RegionalbdmdealtrackerscreenScreen", "/offices/business_development/roles/regional_bdm/deal-tracker");
    }
}

