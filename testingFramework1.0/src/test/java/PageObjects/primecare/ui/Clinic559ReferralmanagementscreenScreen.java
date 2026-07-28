package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic559ReferralmanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 559;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referral_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referralmanagement-screen')]")
	private WebElement referralmanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referralmanagement-title')]")
	private WebElement referralmanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referralmanagement-btn-1')]")
	private WebElement referralmanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referralmanagement-btn-2')]")
	private WebElement referralmanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referralmanagement-btn-3')]")
	private WebElement referralmanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'referralmanagement-content')]")
	private WebElement referralmanagementContent;

    public Clinic559ReferralmanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic559ReferralmanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic559ReferralmanagementscreenScreen", "/offices/clinical/roles/intake_coordinator/referral-management");
    }
}

