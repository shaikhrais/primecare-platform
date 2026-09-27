package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic660TerritoryexpansionmanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 660;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic660TerritoryexpansionmanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic660TerritoryexpansionmanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic660TerritoryexpansionmanagerreportsscreenScreen", "/offices/business_development/roles/territory_expansion_manager/reports");
    }
}

