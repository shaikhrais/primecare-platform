package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic650PartnershipmanagerpartnersscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 650;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_partners-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_partners-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_partners-content')]")
	private WebElement primaryContent;

    public Clinic650PartnershipmanagerpartnersscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic650PartnershipmanagerpartnersscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic650PartnershipmanagerpartnersscreenScreen", "/offices/business_development/roles/partnership_manager/partners");
    }
}

