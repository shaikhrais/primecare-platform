package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic550ProgresstrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 550;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progress_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progress_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progress_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-loading')]")
	private WebElement progresstrackingLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-btn-3')]")
	private WebElement progresstrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-content')]")
	private WebElement progresstrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-screen')]")
	private WebElement progresstrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-title')]")
	private WebElement progresstrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-btn-2')]")
	private WebElement progresstrackingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'progresstracking-btn-1')]")
	private WebElement progresstrackingBtn1;

    public Clinic550ProgresstrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic550ProgresstrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic550ProgresstrackingscreenScreen", "/offices/clinical/roles/physiotherapist/progress-tracking");
    }
}

