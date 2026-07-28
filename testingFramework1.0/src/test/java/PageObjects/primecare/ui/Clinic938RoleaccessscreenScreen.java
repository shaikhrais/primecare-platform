package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic938RoleaccessscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 938;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_access-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_access-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_access-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role-access-btn-save')]")
	private WebElement roleAccessBtnSave;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_screen_access_screen_textfield_input_1')]")
	private WebElement roleScreenAccessScreenTextfieldInput1;

    public Clinic938RoleaccessscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic938RoleaccessscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic938RoleaccessscreenScreen", "/generated/role-access");
    }
}

