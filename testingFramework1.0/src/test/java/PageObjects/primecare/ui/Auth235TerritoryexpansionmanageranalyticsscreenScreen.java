package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth235TerritoryexpansionmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 235;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanageranalytics-title')]")
	private WebElement territoryexpansionmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanageranalytics-content')]")
	private WebElement territoryexpansionmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanageranalytics-screen')]")
	private WebElement territoryexpansionmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanageranalytics-btn-1')]")
	private WebElement territoryexpansionmanageranalyticsBtn1;

    public Auth235TerritoryexpansionmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth235TerritoryexpansionmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth235TerritoryexpansionmanageranalyticsscreenScreen", "/management/territory-expansion-manager-analytics");
    }
}

