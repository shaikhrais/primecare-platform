package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise335FranchiseownerfinancesnapshotscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 335;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_finance_snapshot-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_finance_snapshot-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_finance_snapshot-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerfinancesnapshot-screen')]")
	private WebElement franchiseownerfinancesnapshotScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerfinancesnapshot-btn-3')]")
	private WebElement franchiseownerfinancesnapshotBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerfinancesnapshot-btn-2')]")
	private WebElement franchiseownerfinancesnapshotBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerfinancesnapshot-title')]")
	private WebElement franchiseownerfinancesnapshotTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerfinancesnapshot-content')]")
	private WebElement franchiseownerfinancesnapshotContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerfinancesnapshot-btn-1')]")
	private WebElement franchiseownerfinancesnapshotBtn1;

    public Franchise335FranchiseownerfinancesnapshotscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise335FranchiseownerfinancesnapshotscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise335FranchiseownerfinancesnapshotscreenScreen", "/executive/franchise-owner-finance-snapshot");
    }
}

