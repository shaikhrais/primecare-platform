package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic539NursingtaskscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 539;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursing_task-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursing_task-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursing_task-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-title')]")
	private WebElement nursingtaskTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-btn-1')]")
	private WebElement nursingtaskBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-loading')]")
	private WebElement nursingtaskLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-screen')]")
	private WebElement nursingtaskScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-btn-2')]")
	private WebElement nursingtaskBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-content')]")
	private WebElement nursingtaskContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'nursingtask-btn-3')]")
	private WebElement nursingtaskBtn3;

    public Clinic539NursingtaskscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic539NursingtaskscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic539NursingtaskscreenScreen", "/offices/clinical/roles/rpn/nursing-task");
    }
}

