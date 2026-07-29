package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic850VerificationcenterscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 850;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'verification_center-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'verification_center-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'verification_center-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-logs-btn-${d.appName}')]")
	private WebElement dataCyLogsBtnDappname;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-deploy-card-${d.appName}')]")
	private WebElement dataCyDeployCardDappname;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-logs-close-btn')]")
	private WebElement dataCyLogsCloseBtn;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-live-link-${d.appName}')]")
	private WebElement dataCyLiveLinkDappname;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-logs-viewer-card')]")
	private WebElement dataCyLogsViewerCard;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-logs-close-text-btn')]")
	private WebElement dataCyLogsCloseTextBtn;

    public Clinic850VerificationcenterscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic850VerificationcenterscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic850VerificationcenterscreenScreen", "/verification");
    }
}

