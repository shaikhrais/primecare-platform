package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic914ApikeymanagerscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 914;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_key_manager-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_key_manager-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_key_manager-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_key_manager_screen_iconbutton_button_1')]")
	private WebElement apiKeyManagerScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_key_manager_screen_iconbutton_button_3')]")
	private WebElement apiKeyManagerScreenIconbuttonButton3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_key_manager_screen_iconbutton_button_2')]")
	private WebElement apiKeyManagerScreenIconbuttonButton2;

    public Clinic914ApikeymanagerscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic914ApikeymanagerscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic914ApikeymanagerscreenScreen", "/generated/api-key-manager");
    }
}

