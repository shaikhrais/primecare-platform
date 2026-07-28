package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic355PswclientprofilescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 355;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_client_profile-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_client_profile-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_client_profile-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclientprofile-btn-3')]")
	private WebElement pswclientprofileBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclientprofile-title')]")
	private WebElement pswclientprofileTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclientprofile-content')]")
	private WebElement pswclientprofileContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclientprofile-loading')]")
	private WebElement pswclientprofileLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclientprofile-btn-1')]")
	private WebElement pswclientprofileBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclientprofile-screen')]")
	private WebElement pswclientprofileScreen;

    public Clinic355PswclientprofilescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic355PswclientprofilescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic355PswclientprofilescreenScreen", "/offices/clinical/roles/psw/profile");
    }
}

