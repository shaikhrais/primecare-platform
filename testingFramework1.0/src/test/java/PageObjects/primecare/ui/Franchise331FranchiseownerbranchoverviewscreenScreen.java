package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise331FranchiseownerbranchoverviewscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 331;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_branch_overview-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_branch_overview-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_branch_overview-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerbranchoverview-screen')]")
	private WebElement franchiseownerbranchoverviewScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerbranchoverview-content')]")
	private WebElement franchiseownerbranchoverviewContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerbranchoverview-btn-1')]")
	private WebElement franchiseownerbranchoverviewBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerbranchoverview-btn-2')]")
	private WebElement franchiseownerbranchoverviewBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerbranchoverview-title')]")
	private WebElement franchiseownerbranchoverviewTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseownerbranchoverview-btn-3')]")
	private WebElement franchiseownerbranchoverviewBtn3;

    public Franchise331FranchiseownerbranchoverviewscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise331FranchiseownerbranchoverviewscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise331FranchiseownerbranchoverviewscreenScreen", "/offices/franchise/roles/franchise_owner/branch-overview");
    }
}

