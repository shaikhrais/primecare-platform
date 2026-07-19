package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate494ReleasemanagementscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 494;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'release_management-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'release_management-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'release_management-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-btn-1')]")
	private WebElement releasemanagementBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-screen')]")
	private WebElement releasemanagementScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-btn-3')]")
	private WebElement releasemanagementBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-loading')]")
	private WebElement releasemanagementLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-title')]")
	private WebElement releasemanagementTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-btn-2')]")
	private WebElement releasemanagementBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'releasemanagement-content')]")
	private WebElement releasemanagementContent;

    public Corporate494ReleasemanagementscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate494ReleasemanagementscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate494ReleasemanagementscreenScreen", "/executive/release-management");
    }
}
