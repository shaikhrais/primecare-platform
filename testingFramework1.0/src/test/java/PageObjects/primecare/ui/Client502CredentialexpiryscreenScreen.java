package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client502CredentialexpiryscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 502;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credential_expiry-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credential_expiry-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credential_expiry-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-content')]")
	private WebElement credentialexpiryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-btn-1')]")
	private WebElement credentialexpiryBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-btn-2')]")
	private WebElement credentialexpiryBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-btn-3')]")
	private WebElement credentialexpiryBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-title')]")
	private WebElement credentialexpiryTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-loading')]")
	private WebElement credentialexpiryLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'credentialexpiry-screen')]")
	private WebElement credentialexpiryScreen;

    public Client502CredentialexpiryscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client502CredentialexpiryscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client502CredentialexpiryscreenScreen", "/management/credential-expiry");
    }
}

