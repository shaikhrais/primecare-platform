package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic708PswtasklistscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 708;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_task_list-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_task_list-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'psw_task_list-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tasklist-btn-add')]")
	private WebElement tasklistBtnAdd;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pswtasklist-content')]")
	private WebElement pswtasklistContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'tasklist-btn-add-item')]")
	private WebElement tasklistBtnAddItem;

    public Clinic708PswtasklistscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic708PswtasklistscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic708PswtasklistscreenScreen", "/generated/psw-task-list");
    }
}

