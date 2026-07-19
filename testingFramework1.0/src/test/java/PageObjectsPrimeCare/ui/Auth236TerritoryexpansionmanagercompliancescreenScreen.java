package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth236TerritoryexpansionmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 236;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagercompliance-title')]")
	private WebElement territoryexpansionmanagercomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagercompliance-btn-2')]")
	private WebElement territoryexpansionmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagercompliance-screen')]")
	private WebElement territoryexpansionmanagercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagercompliance-content')]")
	private WebElement territoryexpansionmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagercompliance-btn-1')]")
	private WebElement territoryexpansionmanagercomplianceBtn1;

    public Auth236TerritoryexpansionmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth236TerritoryexpansionmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth236TerritoryexpansionmanagercompliancescreenScreen", "/management/territory-expansion-manager-compliance");
    }
}
