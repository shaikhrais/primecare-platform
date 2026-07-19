package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic658TerritoryexpansionmanagermarketresearchscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 658;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_market_research-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_market_research-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_market_research-content')]")
	private WebElement primaryContent;

    public Clinic658TerritoryexpansionmanagermarketresearchscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic658TerritoryexpansionmanagermarketresearchscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic658TerritoryexpansionmanagermarketresearchscreenScreen", "/offices/business_development/roles/territory_expansion_manager/market-research");
    }
}
