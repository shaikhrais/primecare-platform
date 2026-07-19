package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic657TerritoryexpansionmanagerforecastscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 657;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_forecast-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_forecast-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_forecast-content')]")
	private WebElement primaryContent;

    public Clinic657TerritoryexpansionmanagerforecastscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic657TerritoryexpansionmanagerforecastscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic657TerritoryexpansionmanagerforecastscreenScreen", "/offices/business_development/roles/territory_expansion_manager/forecast");
    }
}
