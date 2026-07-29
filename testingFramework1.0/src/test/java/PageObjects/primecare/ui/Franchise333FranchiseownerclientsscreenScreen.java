package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise333FranchiseownerclientsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 333;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_clients-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_clients-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_clients-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerclients-title')]")
	private WebElement franchiseownerclientsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerclients-content')]")
	private WebElement franchiseownerclientsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerclients-btn-1')]")
	private WebElement franchiseownerclientsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerclients-screen')]")
	private WebElement franchiseownerclientsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerclients-btn-2')]")
	private WebElement franchiseownerclientsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerclients-btn-3')]")
	private WebElement franchiseownerclientsBtn3;

    public Franchise333FranchiseownerclientsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise333FranchiseownerclientsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise333FranchiseownerclientsscreenScreen", "/offices/franchise/roles/franchise_owner/clients");
    }
}

