package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic631RegionalbdmcompetitornotesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 631;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_competitor_notes-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_competitor_notes-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_competitor_notes-content')]")
	private WebElement primaryContent;

    public Clinic631RegionalbdmcompetitornotesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic631RegionalbdmcompetitornotesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic631RegionalbdmcompetitornotesscreenScreen", "/offices/business_development/roles/regional_bdm/competitor-notes");
    }
}

