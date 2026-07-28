package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic656TerritoryexpansionmanagerexpansionplansscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 656;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_expansion_plans-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_expansion_plans-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_expansion_plans-content')]")
	private WebElement primaryContent;

    public Clinic656TerritoryexpansionmanagerexpansionplansscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic656TerritoryexpansionmanagerexpansionplansscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic656TerritoryexpansionmanagerexpansionplansscreenScreen", "/offices/business_development/roles/territory_expansion_manager/expansion-plans");
    }
}

