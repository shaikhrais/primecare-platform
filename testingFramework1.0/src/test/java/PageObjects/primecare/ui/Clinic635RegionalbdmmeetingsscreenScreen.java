package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic635RegionalbdmmeetingsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 635;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_meetings-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_meetings-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_meetings-content')]")
	private WebElement primaryContent;

    public Clinic635RegionalbdmmeetingsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic635RegionalbdmmeetingsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic635RegionalbdmmeetingsscreenScreen", "/offices/business_development/roles/regional_bdm/meetings");
    }
}

