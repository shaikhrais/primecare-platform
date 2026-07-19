package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic659TerritoryexpansionmanageropenterritoriesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 659;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_open_territories-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_open_territories-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_open_territories-content')]")
	private WebElement primaryContent;

    public Clinic659TerritoryexpansionmanageropenterritoriesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic659TerritoryexpansionmanageropenterritoriesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic659TerritoryexpansionmanageropenterritoriesscreenScreen", "/offices/business_development/roles/territory_expansion_manager/open-territories");
    }
}
