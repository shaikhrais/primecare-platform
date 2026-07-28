package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic930ProtocolresolutionlogscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 930;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol_resolution_log-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol_resolution_log-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol_resolution_log-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol_resolution_log_screen_iconbutton_button_1')]")
	private WebElement protocolResolutionLogScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'protocol_resolution_log_screen_elevatedbutton_button_1')]")
	private WebElement protocolResolutionLogScreenElevatedbuttonButton1;

    public Clinic930ProtocolresolutionlogscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic930ProtocolresolutionlogscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic930ProtocolresolutionlogscreenScreen", "/generated/protocol-resolution-log");
    }
}

