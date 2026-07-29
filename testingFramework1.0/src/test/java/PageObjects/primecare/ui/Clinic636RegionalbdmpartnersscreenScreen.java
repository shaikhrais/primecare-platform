package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic636RegionalbdmpartnersscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 636;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_partners-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_partners-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_partners-content')]")
	private WebElement primaryContent;

    public Clinic636RegionalbdmpartnersscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic636RegionalbdmpartnersscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic636RegionalbdmpartnersscreenScreen", "/offices/business_development/roles/regional_bdm/partners");
    }
}

