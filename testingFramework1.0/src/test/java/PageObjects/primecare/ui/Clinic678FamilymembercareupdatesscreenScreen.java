package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic678FamilymembercareupdatesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 678;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_care_updates-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_care_updates-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_care_updates-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymembercareupdatesscreen-screen')]")
	private WebElement familymembercareupdatesscreenScreen;

    public Clinic678FamilymembercareupdatesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic678FamilymembercareupdatesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic678FamilymembercareupdatesscreenScreen", "/generated/family-member-care-updates");
    }
}

