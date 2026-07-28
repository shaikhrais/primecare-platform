package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic665FamilycareupdatesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 665;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_care_updates-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_care_updates-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_care_updates-content')]")
	private WebElement primaryContent;

    public Clinic665FamilycareupdatesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic665FamilycareupdatesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic665FamilycareupdatesscreenScreen", "/offices/client/roles/family_member/care-updates");
    }
}

