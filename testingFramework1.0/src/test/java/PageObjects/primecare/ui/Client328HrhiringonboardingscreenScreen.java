package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client328HrhiringonboardingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 328;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_onboarding-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_onboarding-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_hiring_onboarding-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-screen')]")
	private WebElement hrhiringonboardingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-btn-5')]")
	private WebElement hrhiringonboardingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-btn-1')]")
	private WebElement hrhiringonboardingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-content')]")
	private WebElement hrhiringonboardingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-title')]")
	private WebElement hrhiringonboardingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-btn-4')]")
	private WebElement hrhiringonboardingBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-btn-2')]")
	private WebElement hrhiringonboardingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrhiringonboarding-btn-3')]")
	private WebElement hrhiringonboardingBtn3;

    public Client328HrhiringonboardingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client328HrhiringonboardingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client328HrhiringonboardingscreenScreen", "/offices/franchise/roles/hr_hiring/onboarding");
    }
}

