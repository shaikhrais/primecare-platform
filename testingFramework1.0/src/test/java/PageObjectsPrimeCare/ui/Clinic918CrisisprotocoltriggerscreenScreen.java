package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic918CrisisprotocoltriggerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 918;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'crisis_protocol_trigger-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'crisis_protocol_trigger-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'crisis_protocol_trigger-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'crisis_protocol_trigger_screen_elevatedbutton_button_1')]")
	private WebElement crisisProtocolTriggerScreenElevatedbuttonButton1;

    public Clinic918CrisisprotocoltriggerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic918CrisisprotocoltriggerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic918CrisisprotocoltriggerscreenScreen", "/generated/crisis-protocol-trigger");
    }
}
