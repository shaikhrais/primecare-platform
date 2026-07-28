package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic679FamilymemberemergencycontactsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 679;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_emergency_contacts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_emergency_contacts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_emergency_contacts-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberemergencycontactsscreen-screen')]")
	private WebElement familymemberemergencycontactsscreenScreen;

    public Clinic679FamilymemberemergencycontactsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic679FamilymemberemergencycontactsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic679FamilymemberemergencycontactsscreenScreen", "/generated/family-member-emergency-contacts");
    }
}

