package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth242MyclientsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 242;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_clients-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_clients-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_clients-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclients-title')]")
	private WebElement pswclientsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_clients_screen_textfield_input_1')]")
	private WebElement pswClientsScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclients-btn-1')]")
	private WebElement pswclientsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclients-content')]")
	private WebElement pswclientsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswclients-screen')]")
	private WebElement pswclientsScreen;

    public Auth242MyclientsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth242MyclientsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth242MyclientsscreenScreen", "/offices/clinical/roles/psw/patient-profile");
    }
}

