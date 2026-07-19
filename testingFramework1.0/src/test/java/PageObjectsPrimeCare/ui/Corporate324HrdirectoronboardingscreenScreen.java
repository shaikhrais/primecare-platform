package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate324HrdirectoronboardingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 324;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_onboarding-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_onboarding-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_director_onboarding-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoronboarding-btn-1')]")
	private WebElement hrdirectoronboardingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoronboarding-screen')]")
	private WebElement hrdirectoronboardingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoronboarding-content')]")
	private WebElement hrdirectoronboardingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoronboarding-title')]")
	private WebElement hrdirectoronboardingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoronboarding-btn-3')]")
	private WebElement hrdirectoronboardingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrdirectoronboarding-btn-2')]")
	private WebElement hrdirectoronboardingBtn2;

    public Corporate324HrdirectoronboardingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate324HrdirectoronboardingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate324HrdirectoronboardingscreenScreen", "/executive/hr-director-onboarding");
    }
}
