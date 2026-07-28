package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth237TerritoryexpansionmanagerworkflowscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 237;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_workflow-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_workflow-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_workflow-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerworkflow-screen')]")
	private WebElement territoryexpansionmanagerworkflowScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerworkflow-btn-1')]")
	private WebElement territoryexpansionmanagerworkflowBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerworkflow-title')]")
	private WebElement territoryexpansionmanagerworkflowTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerworkflow-content')]")
	private WebElement territoryexpansionmanagerworkflowContent;

    public Auth237TerritoryexpansionmanagerworkflowscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth237TerritoryexpansionmanagerworkflowscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth237TerritoryexpansionmanagerworkflowscreenScreen", "/management/territory-expansion-manager-workflow");
    }
}

