package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic655TerritoryexpansionmanagerdemographicsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 655;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_demographics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_demographics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_demographics-content')]")
	private WebElement primaryContent;

    public Clinic655TerritoryexpansionmanagerdemographicsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic655TerritoryexpansionmanagerdemographicsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic655TerritoryexpansionmanagerdemographicsscreenScreen", "/offices/business_development/roles/territory_expansion_manager/demographics");
    }
}

