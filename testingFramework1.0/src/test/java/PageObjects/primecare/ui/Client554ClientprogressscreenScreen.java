package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client554ClientprogressscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 554;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_progress-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_progress-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'client_progress-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-loading')]")
	private WebElement clientprogressLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-screen')]")
	private WebElement clientprogressScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-btn-3')]")
	private WebElement clientprogressBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-content')]")
	private WebElement clientprogressContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-btn-1')]")
	private WebElement clientprogressBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-btn-2')]")
	private WebElement clientprogressBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'clientprogress-title')]")
	private WebElement clientprogressTitle;

    public Client554ClientprogressscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client554ClientprogressscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client554ClientprogressscreenScreen", "/offices/clinical/roles/rmt/client-progress");
    }
}

