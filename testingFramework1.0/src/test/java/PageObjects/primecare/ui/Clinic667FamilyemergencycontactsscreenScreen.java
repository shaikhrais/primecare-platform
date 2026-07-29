package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic667FamilyemergencycontactsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 667;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_emergency_contacts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_emergency_contacts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_emergency_contacts-content')]")
	private WebElement primaryContent;

    public Clinic667FamilyemergencycontactsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic667FamilyemergencycontactsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic667FamilyemergencycontactsscreenScreen", "/offices/client/roles/family_member/emergency-contacts");
    }
}

