package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client504OnboardingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 504;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-btn-3')]")
	private WebElement onboardingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-btn-1')]")
	private WebElement onboardingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-loading')]")
	private WebElement onboardingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'onboarding-btn-2')]")
	private WebElement onboardingBtn2;

    public Client504OnboardingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client504OnboardingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client504OnboardingscreenScreen", "/management/onboarding");
    }
}

