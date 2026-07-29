package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client570ResolutiontrackingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 570;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolution_tracking-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolution_tracking-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolution_tracking-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-title')]")
	private WebElement resolutiontrackingTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-btn-3')]")
	private WebElement resolutiontrackingBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-screen')]")
	private WebElement resolutiontrackingScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-btn-2')]")
	private WebElement resolutiontrackingBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-btn-1')]")
	private WebElement resolutiontrackingBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-btn-5')]")
	private WebElement resolutiontrackingBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-btn-4')]")
	private WebElement resolutiontrackingBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'resolutiontracking-content')]")
	private WebElement resolutiontrackingContent;

    public Client570ResolutiontrackingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client570ResolutiontrackingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client570ResolutiontrackingscreenScreen", "/staff/resolution-tracking");
    }
}

