package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic975HronboardingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 975;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_onboarding-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_onboarding-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_onboarding-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_onboarding_screen_elevatedbutton_button_1')]")
	private WebElement hrOnboardingScreenElevatedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_onboarding_screen_iconbutton_button_1')]")
	private WebElement hrOnboardingScreenIconbuttonButton1;

    public Clinic975HronboardingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic975HronboardingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic975HronboardingscreenScreen", "/generated/hr-onboarding");
    }
}
