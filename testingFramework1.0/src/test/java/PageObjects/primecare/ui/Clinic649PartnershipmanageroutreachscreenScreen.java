package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic649PartnershipmanageroutreachscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 649;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_outreach-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_outreach-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_outreach-content')]")
	private WebElement primaryContent;

    public Clinic649PartnershipmanageroutreachscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic649PartnershipmanageroutreachscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic649PartnershipmanageroutreachscreenScreen", "/offices/business_development/roles/partnership_manager/outreach");
    }
}

