package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth246TasklistscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 246;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_tasks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_tasks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_tasks-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswtasks-screen')]")
	private WebElement pswtasksScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswtasks-btn-1')]")
	private WebElement pswtasksBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswtasks-content')]")
	private WebElement pswtasksContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswtasks-title')]")
	private WebElement pswtasksTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswtasks-loading')]")
	private WebElement pswtasksLoading;

    public Auth246TasklistscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth246TasklistscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth246TasklistscreenScreen", "/offices/clinical/roles/psw/visit-checklist");
    }
}
