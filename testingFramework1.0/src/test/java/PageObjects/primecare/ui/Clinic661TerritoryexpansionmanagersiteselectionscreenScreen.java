package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic661TerritoryexpansionmanagersiteselectionscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 661;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_site_selection-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_site_selection-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_site_selection-content')]")
	private WebElement primaryContent;

    public Clinic661TerritoryexpansionmanagersiteselectionscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic661TerritoryexpansionmanagersiteselectionscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic661TerritoryexpansionmanagersiteselectionscreenScreen", "/offices/business_development/roles/territory_expansion_manager/site-selection");
    }
}

