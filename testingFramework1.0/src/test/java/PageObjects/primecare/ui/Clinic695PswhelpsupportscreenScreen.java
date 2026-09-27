package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic695PswhelpsupportscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 695;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_help_support-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_help_support-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_help_support-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswhelp-btn-submit-feedback')]")
	private WebElement pswhelpBtnSubmitFeedback;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswhelp-btn-access-faqs')]")
	private WebElement pswhelpBtnAccessFaqs;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswhelpsupport-content')]")
	private WebElement pswhelpsupportContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswhelp-btn-contact-support')]")
	private WebElement pswhelpBtnContactSupport;

    public Clinic695PswhelpsupportscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic695PswhelpsupportscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic695PswhelpsupportscreenScreen", "/generated/psw-help-support");
    }
}

