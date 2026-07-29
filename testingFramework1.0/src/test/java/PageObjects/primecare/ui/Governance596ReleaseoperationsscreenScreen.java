package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance596ReleaseoperationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 596;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'release_operations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'release_operations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'release_operations-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-btn-2')]")
	private WebElement releaseoperationsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-btn-1')]")
	private WebElement releaseoperationsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-screen')]")
	private WebElement releaseoperationsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-title')]")
	private WebElement releaseoperationsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-btn-3')]")
	private WebElement releaseoperationsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-loading')]")
	private WebElement releaseoperationsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releaseoperations-content')]")
	private WebElement releaseoperationsContent;

    public Governance596ReleaseoperationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance596ReleaseoperationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance596ReleaseoperationsscreenScreen", "/common/release-operations");
    }
}

