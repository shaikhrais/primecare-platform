package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client389SchedulerconflictsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 389;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_conflicts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_conflicts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_conflicts-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-screen')]")
	private WebElement schedulerconflictsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-title')]")
	private WebElement schedulerconflictsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-btn-5')]")
	private WebElement schedulerconflictsBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-btn-2')]")
	private WebElement schedulerconflictsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-btn-3')]")
	private WebElement schedulerconflictsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-btn-1')]")
	private WebElement schedulerconflictsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-content')]")
	private WebElement schedulerconflictsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerconflicts-btn-4')]")
	private WebElement schedulerconflictsBtn4;

    public Client389SchedulerconflictsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client389SchedulerconflictsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client389SchedulerconflictsscreenScreen", "/staff/scheduler-conflicts");
    }
}

