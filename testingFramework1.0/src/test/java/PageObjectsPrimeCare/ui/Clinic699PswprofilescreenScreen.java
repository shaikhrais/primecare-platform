package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic699PswprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 699;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswprofile-content')]")
	private WebElement pswprofileContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswprofile-btn-save')]")
	private WebElement pswprofileBtnSave;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswprofile-btn-edit')]")
	private WebElement pswprofileBtnEdit;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswprofile-btn-update-password')]")
	private WebElement pswprofileBtnUpdatePassword;

    public Clinic699PswprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic699PswprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic699PswprofilescreenScreen", "/generated/psw-profile");
    }
}
