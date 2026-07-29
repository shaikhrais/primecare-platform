package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic653PartnershipmanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 653;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic653PartnershipmanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic653PartnershipmanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic653PartnershipmanagerreportsscreenScreen", "/offices/business_development/roles/partnership_manager/reports");
    }
}

