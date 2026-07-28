package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client558ChiropracticprogresstrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 558;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractic_progress_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractic_progress_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractic_progress_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticprogresstracking-btn-3')]")
	private WebElement chiropracticprogresstrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticprogresstracking-content')]")
	private WebElement chiropracticprogresstrackingContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticprogresstracking-screen')]")
	private WebElement chiropracticprogresstrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticprogresstracking-btn-1')]")
	private WebElement chiropracticprogresstrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticprogresstracking-title')]")
	private WebElement chiropracticprogresstrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropracticprogresstracking-btn-2')]")
	private WebElement chiropracticprogresstrackingBtn2;

    public Client558ChiropracticprogresstrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client558ChiropracticprogresstrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client558ChiropracticprogresstrackingscreenScreen", "/offices/clinical/roles/chiropractor/chiropractic-progress-tracking");
    }
}

