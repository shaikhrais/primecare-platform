package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic681FamilymemberprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 681;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberprofilescreen-screen')]")
	private WebElement familymemberprofilescreenScreen;

    public Clinic681FamilymemberprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic681FamilymemberprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic681FamilymemberprofilescreenScreen", "/generated/family-member-profile");
    }
}

