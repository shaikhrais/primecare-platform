package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise337FranchiseownerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 337;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_reports-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerreports-btn-2')]")
	private WebElement franchiseownerreportsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerreports-btn-3')]")
	private WebElement franchiseownerreportsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerreports-content')]")
	private WebElement franchiseownerreportsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerreports-title')]")
	private WebElement franchiseownerreportsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerreports-btn-1')]")
	private WebElement franchiseownerreportsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerreports-screen')]")
	private WebElement franchiseownerreportsScreen;

    public Franchise337FranchiseownerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise337FranchiseownerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise337FranchiseownerreportsscreenScreen", "/offices/franchise/roles/franchise_owner/reports");
    }
}

