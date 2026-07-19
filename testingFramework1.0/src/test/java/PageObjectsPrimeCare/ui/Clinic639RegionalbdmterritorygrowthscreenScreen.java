package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic639RegionalbdmterritorygrowthscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 639;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_territory_growth-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_territory_growth-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_territory_growth-content')]")
	private WebElement primaryContent;

    public Clinic639RegionalbdmterritorygrowthscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic639RegionalbdmterritorygrowthscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic639RegionalbdmterritorygrowthscreenScreen", "/offices/business_development/roles/regional_bdm/territory-growth");
    }
}
