package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic993GamificationprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 993;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gamification_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gamification_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gamification_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'gamification_profile_screen_textfield_input_1')]")
	private WebElement gamificationProfileScreenTextfieldInput1;

    public Clinic993GamificationprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic993GamificationprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic993GamificationprofilescreenScreen", "/generated/gamification-profile");
    }
}

