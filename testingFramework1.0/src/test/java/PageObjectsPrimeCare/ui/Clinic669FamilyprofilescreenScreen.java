package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic669FamilyprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 669;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_profile-content')]")
	private WebElement primaryContent;

    public Clinic669FamilyprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic669FamilyprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic669FamilyprofilescreenScreen", "/offices/client/roles/family_member/profile");
    }
}
