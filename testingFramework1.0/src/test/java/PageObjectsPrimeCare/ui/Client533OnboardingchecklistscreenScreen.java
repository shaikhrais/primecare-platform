package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client533OnboardingchecklistscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 533;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding_checklist-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding_checklist-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding_checklist-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-btn-3')]")
	private WebElement onboardingchecklistBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-title')]")
	private WebElement onboardingchecklistTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-btn-2')]")
	private WebElement onboardingchecklistBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-btn-5')]")
	private WebElement onboardingchecklistBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-screen')]")
	private WebElement onboardingchecklistScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-content')]")
	private WebElement onboardingchecklistContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-btn-1')]")
	private WebElement onboardingchecklistBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboardingchecklist-btn-4')]")
	private WebElement onboardingchecklistBtn4;

    public Client533OnboardingchecklistscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client533OnboardingchecklistscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client533OnboardingchecklistscreenScreen", "/staff/onboarding-checklist");
    }
}
