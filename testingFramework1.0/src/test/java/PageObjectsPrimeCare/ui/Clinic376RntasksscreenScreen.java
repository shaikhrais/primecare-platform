package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic376RntasksscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 376;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_tasks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_tasks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_tasks-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-btn-3')]")
	private WebElement rntasksBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-title')]")
	private WebElement rntasksTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-btn-2')]")
	private WebElement rntasksBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-screen')]")
	private WebElement rntasksScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-btn-1')]")
	private WebElement rntasksBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-content')]")
	private WebElement rntasksContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rntasks-loading')]")
	private WebElement rntasksLoading;

    public Clinic376RntasksscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic376RntasksscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic376RntasksscreenScreen", "/offices/clinical/roles/rn/rn-tasks");
    }
}
