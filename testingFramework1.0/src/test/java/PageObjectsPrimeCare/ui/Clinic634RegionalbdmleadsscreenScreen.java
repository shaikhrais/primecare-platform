package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic634RegionalbdmleadsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 634;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_leads-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_leads-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_leads-content')]")
	private WebElement primaryContent;

    public Clinic634RegionalbdmleadsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic634RegionalbdmleadsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic634RegionalbdmleadsscreenScreen", "/offices/business_development/roles/regional_bdm/leads");
    }
}
