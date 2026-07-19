package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic996SitereadinessscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 996;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'site_readiness-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'site_readiness-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'site_readiness-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'site_readiness_screen_textfield_input_1')]")
	private WebElement siteReadinessScreenTextfieldInput1;

    public Clinic996SitereadinessscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic996SitereadinessscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic996SitereadinessscreenScreen", "/generated/site-readiness");
    }
}
