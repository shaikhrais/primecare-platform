package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic936ResponsebotauditscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 936;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'response_bot_audit-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'response_bot_audit-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'response_bot_audit-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'response_bot_audit_screen_iconbutton_button_1')]")
	private WebElement responseBotAuditScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'response_bot_audit_screen_textfield_input_1')]")
	private WebElement responseBotAuditScreenTextfieldInput1;

    public Clinic936ResponsebotauditscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic936ResponsebotauditscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic936ResponsebotauditscreenScreen", "/generated/response-bot-audit");
    }
}

