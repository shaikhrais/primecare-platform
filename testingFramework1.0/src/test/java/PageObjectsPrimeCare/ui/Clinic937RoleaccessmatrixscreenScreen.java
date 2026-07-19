package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic937RoleaccessmatrixscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 937;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_access_matrix-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_access_matrix-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_access_matrix-content')]")
	private WebElement primaryContent;

    public Clinic937RoleaccessmatrixscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic937RoleaccessmatrixscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic937RoleaccessmatrixscreenScreen", "/generated/role-access-matrix");
    }
}
