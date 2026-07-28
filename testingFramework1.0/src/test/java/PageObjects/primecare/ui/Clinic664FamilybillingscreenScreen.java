package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic664FamilybillingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 664;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_billing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_billing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_billing-content')]")
	private WebElement primaryContent;

    public Clinic664FamilybillingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic664FamilybillingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic664FamilybillingscreenScreen", "/offices/client/roles/family_member/billing");
    }
}

