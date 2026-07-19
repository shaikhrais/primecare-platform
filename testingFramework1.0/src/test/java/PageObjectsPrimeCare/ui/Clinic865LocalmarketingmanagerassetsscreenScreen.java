package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic865LocalmarketingmanagerassetsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 865;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_assets-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_assets-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_assets-content')]")
	private WebElement primaryContent;

    public Clinic865LocalmarketingmanagerassetsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic865LocalmarketingmanagerassetsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic865LocalmarketingmanagerassetsscreenScreen", "/generated/local-marketing-manager-assets");
    }
}
