package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic694PswcheckinscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 694;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_check_in-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_check_in-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_check_in-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcheckin-btn-checkin')]")
	private WebElement pswcheckinBtnCheckin;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcheckin-btn-help')]")
	private WebElement pswcheckinBtnHelp;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswcheckin-content')]")
	private WebElement pswcheckinContent;

    public Clinic694PswcheckinscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic694PswcheckinscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic694PswcheckinscreenScreen", "/generated/psw-check-in");
    }
}

