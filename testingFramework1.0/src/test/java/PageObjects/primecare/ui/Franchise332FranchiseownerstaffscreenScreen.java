package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise332FranchiseownerstaffscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 332;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_staff-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_staff-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_staff-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerstaff-btn-1')]")
	private WebElement franchiseownerstaffBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerstaff-screen')]")
	private WebElement franchiseownerstaffScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerstaff-btn-3')]")
	private WebElement franchiseownerstaffBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerstaff-content')]")
	private WebElement franchiseownerstaffContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerstaff-btn-2')]")
	private WebElement franchiseownerstaffBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerstaff-title')]")
	private WebElement franchiseownerstaffTitle;

    public Franchise332FranchiseownerstaffscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise332FranchiseownerstaffscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise332FranchiseownerstaffscreenScreen", "/offices/franchise/roles/franchise_owner/staff");
    }
}

