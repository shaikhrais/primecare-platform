package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth245ShifttrackerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 245;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_shift_tracker-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_shift_tracker-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_shift_tracker-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswshifttracker-screen')]")
	private WebElement pswshifttrackerScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswshifttracker-content')]")
	private WebElement pswshifttrackerContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswshifttracker-title')]")
	private WebElement pswshifttrackerTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswshifttracker-btn-1')]")
	private WebElement pswshifttrackerBtn1;

    public Auth245ShifttrackerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth245ShifttrackerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth245ShifttrackerscreenScreen", "/offices/clinical/roles/psw/schedule");
    }
}

