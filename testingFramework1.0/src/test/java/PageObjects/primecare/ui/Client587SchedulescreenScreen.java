package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client587SchedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 587;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-btn-2')]")
	private WebElement scheduleBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-btn-1')]")
	private WebElement scheduleBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-btn-3')]")
	private WebElement scheduleBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedule-loading')]")
	private WebElement scheduleLoading;

    public Client587SchedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client587SchedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client587SchedulescreenScreen", "/offices/clinical/roles/caregiver/psw-schedule");
    }
}

