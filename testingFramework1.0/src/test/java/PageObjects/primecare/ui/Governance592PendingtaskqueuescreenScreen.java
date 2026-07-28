package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance592PendingtaskqueuescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 592;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pending_task_queue-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pending_task_queue-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pending_task_queue-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-btn-2')]")
	private WebElement pendingtaskqueueBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-btn-1')]")
	private WebElement pendingtaskqueueBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-title')]")
	private WebElement pendingtaskqueueTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-loading')]")
	private WebElement pendingtaskqueueLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-btn-3')]")
	private WebElement pendingtaskqueueBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-content')]")
	private WebElement pendingtaskqueueContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'pendingtaskqueue-screen')]")
	private WebElement pendingtaskqueueScreen;

    public Governance592PendingtaskqueuescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance592PendingtaskqueuescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance592PendingtaskqueuescreenScreen", "/common/pending-task-queue");
    }
}

