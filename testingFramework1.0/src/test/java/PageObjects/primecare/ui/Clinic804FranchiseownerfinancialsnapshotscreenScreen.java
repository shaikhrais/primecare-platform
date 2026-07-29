package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic804FranchiseownerfinancialsnapshotscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 804;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_financial_snapshot-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_financial_snapshot-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_financial_snapshot-content')]")
	private WebElement primaryContent;

    public Clinic804FranchiseownerfinancialsnapshotscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic804FranchiseownerfinancialsnapshotscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic804FranchiseownerfinancialsnapshotscreenScreen", "/offices/franchise/roles/franchise_owner/financial-snapshot");
    }
}

