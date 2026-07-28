package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic835ScreenstatusscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 835;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_status-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_status-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_status-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-screen-search-input')]")
	private WebElement dataCyScreenSearchInput;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen-status-btn-refresh')]")
	private WebElement screenStatusBtnRefresh;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-tab-strings')]")
	private WebElement dataCyTabStrings;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-lang-chip-$langCode')]")
	private WebElement dataCyLangChipLangcode;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-screen-item-${screen.screenName}')]")
	private WebElement dataCyScreenItemScreenscreenname;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-tab-buttons')]")
	private WebElement dataCyTabButtons;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-tab-components')]")
	private WebElement dataCyTabComponents;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-app-dropdown')]")
	private WebElement dataCyAppDropdown;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-tabs-bar')]")
	private WebElement dataCyTabsBar;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'data-cy-tab-compliance')]")
	private WebElement dataCyTabCompliance;

    public Clinic835ScreenstatusscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic835ScreenstatusscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic835ScreenstatusscreenScreen", "/governance/screen-status");
    }
}

