package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic662TerritoryexpansionmanagerterritorymapscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 662;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_territory_map-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_territory_map-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_territory_map-content')]")
	private WebElement primaryContent;

    public Clinic662TerritoryexpansionmanagerterritorymapscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic662TerritoryexpansionmanagerterritorymapscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic662TerritoryexpansionmanagerterritorymapscreenScreen", "/offices/business_development/roles/territory_expansion_manager/territory-map");
    }
}

