package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth251RncareplansscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 251;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plans-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plans-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plans-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplans-btn-2')]")
	private WebElement rncareplansBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplans-btn-1')]")
	private WebElement rncareplansBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplans-screen')]")
	private WebElement rncareplansScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_care_plans_screen_textfield_input_1')]")
	private WebElement rnCarePlansScreenTextfieldInput1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplans-title')]")
	private WebElement rncareplansTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rncareplans-content')]")
	private WebElement rncareplansContent;

    public Auth251RncareplansscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth251RncareplansscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth251RncareplansscreenScreen", "/offices/clinical/roles/rn/rn-care-plans");
    }
}

