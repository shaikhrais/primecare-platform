package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic945UsermanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 945;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'user_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'user_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'user_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'user_management_screen_iconbutton_button_1')]")
	private WebElement userManagementScreenIconbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'user_management_screen_iconbutton_button_2')]")
	private WebElement userManagementScreenIconbuttonButton2;

    public Clinic945UsermanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic945UsermanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic945UsermanagementscreenScreen", "/generated/user-management");
    }
}

