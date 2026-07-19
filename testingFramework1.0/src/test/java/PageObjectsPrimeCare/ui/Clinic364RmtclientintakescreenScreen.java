package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic364RmtclientintakescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 364;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_client_intake-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_client_intake-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_client_intake-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-btn-2')]")
	private WebElement rmtclientintakeBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-title')]")
	private WebElement rmtclientintakeTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-btn-1')]")
	private WebElement rmtclientintakeBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-btn-3')]")
	private WebElement rmtclientintakeBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-loading')]")
	private WebElement rmtclientintakeLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-screen')]")
	private WebElement rmtclientintakeScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtclientintake-content')]")
	private WebElement rmtclientintakeContent;

    public Clinic364RmtclientintakescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic364RmtclientintakescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic364RmtclientintakescreenScreen", "/offices/clinical/roles/rmt/client-intake");
    }
}
