package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic637RegionalbdmreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 637;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_reports-content')]")
	private WebElement primaryContent;

    public Clinic637RegionalbdmreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic637RegionalbdmreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic637RegionalbdmreportsscreenScreen", "/offices/business_development/roles/regional_bdm/reports");
    }
}
