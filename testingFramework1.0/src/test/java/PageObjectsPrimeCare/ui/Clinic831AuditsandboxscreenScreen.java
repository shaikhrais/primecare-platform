package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic831AuditsandboxscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 831;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_sandbox-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_sandbox-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'audit_sandbox-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_screen_view_iconbutton_button_1')]")
	private WebElement dynamicScreenViewIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_screen_view_textfield_input_1')]")
	private WebElement dynamicScreenViewTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'dynamic_screen_view_textbutton_button_1')]")
	private WebElement dynamicScreenViewTextbuttonButton1;

    public Clinic831AuditsandboxscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic831AuditsandboxscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic831AuditsandboxscreenScreen", "/generated/audit-sandbox");
    }
}
