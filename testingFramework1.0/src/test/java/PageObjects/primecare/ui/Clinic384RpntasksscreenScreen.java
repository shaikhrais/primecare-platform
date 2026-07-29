package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic384RpntasksscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 384;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_tasks-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_tasks-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_tasks-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-content')]")
	private WebElement rpntasksContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-title')]")
	private WebElement rpntasksTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-loading')]")
	private WebElement rpntasksLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-screen')]")
	private WebElement rpntasksScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-btn-3')]")
	private WebElement rpntasksBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-btn-2')]")
	private WebElement rpntasksBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpntasks-btn-1')]")
	private WebElement rpntasksBtn1;

    public Clinic384RpntasksscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic384RpntasksscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic384RpntasksscreenScreen", "/offices/clinical/roles/rpn/rpn-tasks");
    }
}

