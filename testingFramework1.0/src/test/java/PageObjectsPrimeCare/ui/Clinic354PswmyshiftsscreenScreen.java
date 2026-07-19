package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic354PswmyshiftsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 354;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_my_shifts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_my_shifts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_my_shifts-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-btn-2')]")
	private WebElement pswmyshiftsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-btn-3')]")
	private WebElement pswmyshiftsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-loading')]")
	private WebElement pswmyshiftsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-screen')]")
	private WebElement pswmyshiftsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-title')]")
	private WebElement pswmyshiftsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-btn-1')]")
	private WebElement pswmyshiftsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswmyshifts-content')]")
	private WebElement pswmyshiftsContent;

    public Clinic354PswmyshiftsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic354PswmyshiftsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic354PswmyshiftsscreenScreen", "/offices/clinical/roles/psw/psw-my-shifts");
    }
}
