package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic717CeofranchiseoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 717;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_franchise_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_franchise_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceo_franchise_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ceofranchiseoverviewscreen-screen')]")
	private WebElement ceofranchiseoverviewscreenScreen;

    public Clinic717CeofranchiseoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic717CeofranchiseoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic717CeofranchiseoverviewscreenScreen", "/offices/corporate/roles/ceo/franchise-overview");
    }
}
