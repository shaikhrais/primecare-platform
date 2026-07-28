package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic913AdminusermanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 913;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_user_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_user_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_user_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'admin_user_management_iconbutton_button_1')]")
	private WebElement adminUserManagementIconbuttonButton1;

    public Clinic913AdminusermanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic913AdminusermanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic913AdminusermanagementscreenScreen", "/generated/admin-user-management");
    }
}

